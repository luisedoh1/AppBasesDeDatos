/*
Important: Run with = npm start"
*/
require('dotenv').config();
const express = require('express');
const sql = require('mssql/msnodesqlv8');
const cors = require('cors');
const path = require('path');
const app = express();

app.use(cors());
app.use(express.static(path.join(__dirname, '../public')));
app.use(express.json());
app.set('view engine', 'ejs'); // Set EJS as the view engine
app.set('views', path.join(__dirname, '../public')); // Set the directory for EJS templates


const connectionString = `Driver={ODBC Driver 17 for SQL Server};Server=localhost\\SQLEXPRESS;Database=ProjectoLuis;Trusted_Connection=yes;`;

const config = {
    connectionString: connectionString,
    Port: 1450,
    options: {
        trustedConnection: true
    }
};



// Connect to your SQL Server database
sql.connect(config).then(connectionPool => {
    console.log('Connected to SQL Server successfully.');

    app.get('/register', (req, res) => {
        res.render('register.ejs');
    });

    // Handle registration form submission
    app.post('/api/register', async (req, res) => {

        console.log(req.body);

        let transaction;

        // Destructure all fields from the request body
        const {
            nombreCompleto,
            fechaNacimiento,
            email,
            numeroCelular,
            genero,
            ocupacion,
            tipoPersona,
            tipoIdentificacion,
            identificationNumber,
            issueDate,
            fechaExpiracion // Assuming you add this field to your Identification table
        } = req.body;

        try {
            // Begin transaction
            transaction = new sql.Transaction(/* [pool] */);
            await transaction.begin();

            const personRequest = new sql.Request(transaction);
            const personResult = await personRequest
                .input('NombreCompleto', sql.NVarChar, nombreCompleto)
                .input('FechaNacimiento', sql.Date, fechaNacimiento)
                .input('Email', sql.NVarChar, email)
                .input('NumeroCelular', sql.NVarChar, numeroCelular)
                .input('Genero', sql.NVarChar, genero)
                .input('Ocupacion', sql.NVarChar, ocupacion)
                .input('TipoPersona', sql.NVarChar, tipoPersona)
                .query('INSERT INTO Person (NombreCompleto, FechaNacimiento, Email, NumeroCelular, Genero, Ocupacion, TipoPersona) OUTPUT INSERTED.PersonID VALUES (@NombreCompleto, @FechaNacimiento, @Email, @NumeroCelular, @Genero, @Ocupacion, @TipoPersona)');

            const personID = personResult.recordset[0].PersonID;

            const identificationRequest = new sql.Request(transaction);
            await identificationRequest
                .input('PersonID', sql.Int, personID)
                .input('TipoIdentificacion', sql.NVarChar, tipoIdentificacion)
                .input('IdentificationNumber', sql.NVarChar, identificationNumber)
                .input('IssueDate', sql.Date, issueDate)
                .input('FechaExpiracion', sql.Date, fechaExpiracion) // You need to add this column to your Identification table
                .query('INSERT INTO Identification (PersonID, TipoIdentificacion, IdentificationNumber, IssueDate, FechaExpiracion) VALUES (@PersonID, @TipoIdentificacion, @IdentificationNumber, @IssueDate, @FechaExpiracion)');

            // Commit transaction
            await transaction.commit();

            res.json({ message: 'Registration successful', personID: personID });
        } catch (err) {
            // Rollback transaction if any errors
            if (transaction) await transaction.rollback();

            console.error(err);
            res.status(500).send('Error processing registration: ' + err.message);
        }
    });

    // Add a new endpoint for the address form submission
    app.post('/api/address', async (req, res) => {
        const { PersonID, Street, City, State, Country, PostalCode } = req.body;
        console.log(req.body);
        let transaction;

        try {
            // Begin transaction
            transaction = new sql.Transaction(connectionPool);
            await transaction.begin();

            const addressRequest = new sql.Request(transaction);
            await addressRequest
                .input('PersonID', sql.Int, PersonID)
                .input('Street', sql.NVarChar, Street)
                .input('City', sql.NVarChar, City)
                .input('State', sql.NVarChar, State)
                .input('Country', sql.NVarChar, Country)
                .input('PostalCode', sql.NVarChar, PostalCode)
                .query('INSERT INTO Address (PersonID, Street, City, State, Country, PostalCode) VALUES (@PersonID, @Street, @City, @State, @Country, @PostalCode)');

            // Commit transaction
            await transaction.commit();
            res.json({ message: 'Address saved successfully' });
        } catch (err) {
            // Rollback transaction if any errors
            if (transaction) {
                await transaction.rollback();
            }
            console.error('SQL error', err);
            res.status(500).send('Error saving address: ' + err.message);
        }
    });

    app.get('/', async (req, res) => {
        try {
            const pool = await sql.connect(config);
            const result = await pool.request().query('SELECT * FROM Person');
            const clients = result.recordset;
            // Pass an additional variable to indicate if the clients array is empty
            res.render('index', { clients, noClients: clients.length === 0 });
        } catch (error) {
            console.error('Failed to fetch clients:', error);
            res.status(500).send('An error occurred while fetching clients.');
        }
    });


// Fetch clients from the database
    async function fetchClientsFromDatabase() {
        try {
            const request = new sql.Request();
            const result = await request.query('SELECT * FROM Person'); // Adjust the SQL query as needed
            return result.recordset;
        } catch (error) {
            console.error('Failed to fetch clients:', error);
            throw error;
        }
    }

// Route to handle client deletion
    app.post('/clients/:id/delete', async (req, res) => {
        const personID = req.params.id;
        try {
            const request = new sql.Request();
            await request.input('PersonID', sql.Int, personID)
                .query('DELETE FROM Person WHERE PersonID = @PersonID');
            res.redirect('/');
        } catch (error) {
            console.error('Failed to delete client:', error);
            res.status(500).send('An error occurred while deleting the client.');
        }
    });

// Route to handle client editing
// This route should show a form to edit a client's data
    app.get('/clients/:id/edit', async (req, res) => {
        const personID = req.params.id;
        try {
            const request = new sql.Request();
            const result = await request.input('PersonID', sql.Int, personID)
                .query('SELECT * FROM Person WHERE PersonID = @PersonID');
            const client = result.recordset[0];
            res.render('edit-client', { client }); // You will need an 'edit-client.ejs' view for this
        } catch (error) {
            console.error('Failed to fetch client for editing:', error);
            res.status(500).send('An error occurred while fetching the client for editing.');
        }
    });

// Route to update client's information after editing
    app.post('/clients/:id/update', async (req, res) => {
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
            await request.input('PersonID', sql.Int, personID)
                .input('NombreCompleto', sql.NVarChar, nombreCompleto)
                .input('FechaNacimiento', sql.Date, fechaNacimiento)
                .input('Email', sql.NVarChar, email)
                .input('NumeroCelular', sql.NVarChar, numeroCelular)
                .input('Genero', sql.NVarChar, genero)
                .input('Ocupacion', sql.NVarChar, ocupacion)
                .input('TipoPersona', sql.NVarChar, tipoPersona)
                .query('UPDATE Person SET NombreCompleto = @NombreCompleto, FechaNacimiento = @FechaNacimiento, Email = @Email, NumeroCelular = @NumeroCelular, Genero = @Genero, Ocupacion = @Ocupacion, TipoPersona = @TipoPersona WHERE PersonID = @PersonID');
            res.redirect('/');
        } catch (error) {
            console.error('Failed to update client:', error);
            res.status(500).send('An error occurred while updating the client.');
        }
    });

    // Start the server
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}).catch(err => {
    console.error('Failed to open a SQL Server connection.', err);
});

