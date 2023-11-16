/*
Important: Run this, not the script.js. It's run with "node .\src\Backend\server.js"
*/
require('dotenv').config();
const express = require('express');
const sql = require('mssql/msnodesqlv8');
const cors = require('cors');
const { join } = require("path");
const app = express();

app.use(cors());
app.use(express.static(join(__dirname, '../public')));
app.use(express.json());

const connectionString = `Driver={ODBC Driver 17 for SQL Server};Server=LAPTOP-LUISHQ;Database=Proyecto;Trusted_Connection=yes;`;

const config = {
    connectionString: connectionString,
    options: {
        trustedConnection: true
    }
};

// Connect to your SQL Server database
sql.connect(config).then(connectionPool => {
    console.log('Connected to SQL Server successfully.');

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

    // Start the server
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}).catch(err => {
    console.error('Failed to open a SQL Server connection.', err);
});