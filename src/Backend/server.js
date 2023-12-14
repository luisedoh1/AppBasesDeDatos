/*
Important: Run with = npm start"
*/
require("dotenv").config();
const express = require("express");
const sql = require("mssql/msnodesqlv8");
const cors = require("cors");
const path = require("path");
const app = express();

app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));
//app.use(express.static(path.join(__dirname, "../public")));
app.use(express.json());
app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "../public"));

const connectionString = `Driver={ODBC Driver 17 for SQL Server};Server=localhost;Database=Base_Proyecto;Trusted_Connection=yes;`;

const config = {
    connectionString: connectionString,
    Port: 1450,
    options: {
        trustedConnection: true
    }
};

// Connect to your SQL Server database
sql
    .connect(config)
    .then((connectionPool) => {
        console.log("Connected to SQL Server successfully.");

        app.get("/register", (req, res) => {
            res.render("register.ejs");
        });

        app.post("/api/register", async (req, res) => {
            console.log(req.body);
            let transaction;

            const {
                primerNombre,
                segundoNombre,
                primerApellido,
                segundoApellido,
                fechaNacimiento,
                lugarNacimiento,
                genero,
                numeroDependientes,
                profesion,
                actividadEcon,
                tipoPersona
            } = req.body;

            try {
                transaction = new sql.Transaction(/* [pool] */);
                await transaction.begin();

                const personRequest = new sql.Request(transaction);
                const personResult = await personRequest
                    .input("primerNombre", sql.NVarChar, primerNombre)
                    .input("segundoNombre", sql.NVarChar, segundoNombre) // changed from "SegundoNombre" to "segundoNombre"
                    .input("primerApellido", sql.NVarChar, primerApellido) // changed from "PrimerApellido" to "primerApellido"
                    .input("segundoApellido", sql.NVarChar, segundoApellido) // changed from "SegundoApellido" to "segundoApellido"
                    .input("Fecha_Nacimiento", sql.Date, fechaNacimiento) // changed from "FechaNacimiento" to "Fecha_Nacimiento"
                    .input("Lugar_Nacimiento", sql.NVarChar, lugarNacimiento) // changed from "LugarNacimiento" to "Lugar_Nacimiento"
                    .input("Profesion_ID", sql.SmallInt, profesion) // changed from "Profesion" to "Profesion_ID" and sql.TinyInt to sql.SmallInt
                    .input("GeneroID", sql.TinyInt, genero) // changed from "Genero" to "GeneroID"
                    .input("Tipo_PersonaID", sql.TinyInt, tipoPersona) // changed from "TipoPersona" to "Tipo_PersonaID"
                    .input("Numero_Dependientes", sql.TinyInt, numeroDependientes) // changed from "NumeroDependientes" to "Numero_Dependientes"
                    .input("ActividadEconomica_ID", sql.TinyInt, actividadEcon) // changed from "ActividadEconomica" to "ActividadEconomica_ID"
                    .query(
                        "EXEC insertarPersona @primerNombre, @segundoNombre, @primerApellido, @segundoApellido, @Fecha_Nacimiento, @Lugar_Nacimiento, @Numero_Dependientes, @Tipo_PersonaID, @GeneroID, @ActividadEconomica_ID, @Profesion_ID, 1, NULL;"
                    );


                //const personID = personResult.recordset[0].PersonID;
                /*
                const identificationRequest = new sql.Request(transaction);
                await identificationRequest
                  .input("PersonID", sql.Int, personID)
                  .input("TipoIdentificacion", sql.NVarChar, tipoIdentificacion)
                  .input("IdentificationNumber", sql.NVarChar, identificationNumber)
                  .input("IssueDate", sql.Date, issueDate)
                  .input("FechaExpiracion", sql.Date, fechaExpiracion)
                  .query(
                    "INSERT INTO Identification (PersonID, TipoIdentificacion, IdentificationNumber, IssueDate, FechaExpiracion) VALUES (@PersonID, @TipoIdentificacion, @IdentificationNumber, @IssueDate, @FechaExpiracion)"
                  );*/

                await transaction.commit();

                res.json({message: "Registration successful", tipoPersona: tipoPersona});
            } catch (err) {
                if (transaction) await transaction.rollback();

                console.error(err);
                res.status(500).send("Error processing registration: " + err.message);
            }
        });

        // Add a new endpoint for the address form submission
        app.post("/api/address", async (req, res) => {
            const {PersonID, Street, City, State, Country, PostalCode} = req.body;
            console.log(req.body);
            let transaction;

            try {
                // Begin transaction
                transaction = new sql.Transaction(connectionPool);
                await transaction.begin();

                const addressRequest = new sql.Request(transaction);
                await addressRequest
                    .input("PersonID", sql.Int, PersonID)
                    .input("Street", sql.NVarChar, Street)
                    .input("City", sql.NVarChar, City)
                    .input("State", sql.NVarChar, State)
                    .input("Country", sql.NVarChar, Country)
                    .input("PostalCode", sql.NVarChar, PostalCode)
                    .query(
                        "INSERT INTO Address (PersonID, Street, City, State, Country, PostalCode) VALUES (@PersonID, @Street, @City, @State, @Country, @PostalCode)"
                    );

                // Commit transaction
                await transaction.commit();
                res.json({message: "Address saved successfully"});
            } catch (err) {
                if (transaction) {
                    await transaction.rollback();
                }
                console.error("SQL error", err);
                res.status(500).send("Error saving address: " + err.message);
            }
        });

        app.get("/", async (req, res) => {
            const pageSize = 10;
            let page = parseInt(req.query.page) || 1;

            try {
                const pool = await sql.connect(config);
                const clientCountResult = await pool
                    .request()
                    .query("SELECT COUNT(*) AS count FROM Persona.PERSONA");
                const totalClients = clientCountResult.recordset[0].count;
                const totalPages = Math.ceil(totalClients / pageSize);

                // Calculate the starting row for the current page
                const startingRow = (page - 1) * pageSize;
                const result = await pool
                    .request()
                    .query(
                        `SELECT *
                         FROM Persona.PERSONA
                         ORDER BY PersonaID
                         OFFSET ${startingRow} ROWS FETCH NEXT ${pageSize} ROWS ONLY`
                    );

                const clients = result.recordset;
                res.render("index", {
                    clients,
                    noClients: clients.length === 0,
                    currentPage: page,
                    totalPages: totalPages,
                    hasNextPage: page < totalPages,
                    hasPreviousPage: page > 1,
                    nextPage: page + 1,
                    previousPage: page - 1,
                });
            } catch (error) {
                console.error("Failed to fetch clients:", error);
                res.status(500).send("An error occurred while fetching clients.");
            }
        });

        // Fetch clients from the database
        async function fetchClientsFromDatabase() {
            try {
                const request = new sql.Request();
                const result = await request.query("SELECT * FROM Person");
                return result.recordset;
            } catch (error) {
                console.error("Failed to fetch clients:", error);
                throw error;
            }
        }

        app.post("/clients/:id/delete", async (req, res) => {
            const personID = req.params.id;
            let transaction;

            try {
                transaction = new sql.Transaction();
                await transaction.begin();
                const deleteIdentificationRequest = new sql.Request(transaction);
                await deleteIdentificationRequest
                    .input("PersonID", sql.Int, personID)
                    .query("DELETE FROM Identification WHERE PersonID = @PersonID");

                const deletePersonRequest = new sql.Request(transaction);
                await deletePersonRequest
                    .input("PersonID", sql.Int, personID)
                    .query("DELETE FROM Person WHERE PersonID = @PersonID");

                await transaction.commit();
                res.redirect("/");
            } catch (error) {
                console.error("Failed to delete client:", error);
                if (transaction) {
                    await transaction.rollback();
                }
                res.status(500).send("An error occurred while deleting the client.");
            }
        });

        // This route should show a form to edit a client's data
        app.get("/clients/:id/edit", async (req, res) => {
            const personID = req.params.id;
            try {
                const request = new sql.Request();
                const result = await request
                    .input("PersonID", sql.Int, personID)
                    .query("SELECT * FROM Person WHERE PersonID = @PersonID");
                const client = result.recordset[0];
                res.render("edit-client", {client});
            } catch (error) {
                console.error("Failed to fetch client for editing:", error);
                res
                    .status(500)
                    .send("An error occurred while fetching the client for editing.");
            }
        });

        app.get("/clients/:id/edit-script.js", (req, res) => {
            const personID = req.params.id;

            // Generate the file path for the client-specific JavaScript file
            const scriptFilePath = path.join(__dirname, `../public/edit-script.js`);

            // Serve the client-specific JavaScript file
            res.sendFile(scriptFilePath);
        });

        // Route to update client's information after editing
        app.post("/clients/:id/update", async (req, res) => {
            const personID = req.params.id;
            const {
                nombreCompleto,
                fechaNacimiento,
                email,
                numeroCelular,
                genero,
                ocupacion,
                tipoPersona,
            } = req.body;
            try {
                const request = new sql.Request();
                await request
                    .input("PersonID", sql.Int, personID)
                    .input("NombreCompleto", sql.NVarChar, nombreCompleto)
                    .input("FechaNacimiento", sql.Date, fechaNacimiento)
                    .input("Email", sql.NVarChar, email)
                    .input("NumeroCelular", sql.NVarChar, numeroCelular)
                    .input("Genero", sql.NVarChar, genero)
                    .input("Ocupacion", sql.NVarChar, ocupacion)
                    .input("TipoPersona", sql.NVarChar, tipoPersona)
                    .query(
                        "UPDATE Person SET NombreCompleto = @NombreCompleto, FechaNacimiento = @FechaNacimiento, Email = @Email, NumeroCelular = @NumeroCelular, Genero = @Genero, Ocupacion = @Ocupacion, TipoPersona = @TipoPersona WHERE PersonID = @PersonID"
                    );
            } catch (error) {
                console.error("Failed to update client:", error);
                res.status(500).send("An error occurred while updating the client.");
            }
        });

        // Start the server
        const PORT = process.env.PORT || 3000;
        app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
    })
    .catch((err) => {
        console.error("Failed to open a SQL Server connection.", err);
    });
