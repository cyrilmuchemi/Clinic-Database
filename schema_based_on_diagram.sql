CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    name text NOT NULL,
    date_of_birth date NOT NULL
);

CREATE TABLE medical_histories(
    id SERIAL PRIMARY KEY,
    patient_id integer NOT NULL REFERENCES patients(id),
    admitted_at timestamp NOT NULL,
    status varchar(50) NOT NULL
);

CREATE INDEX ON medical_histories (patient_id);

CREATE TABLE treatments(
    id SERIAL PRIMARY KEY,
    type varchar(50) NOT NULL,
    name varchar(50) NOT NULL
);

CREATE TABLE medical_histories_has_treatments(
    medical_history_id integer NOT NULL REFERENCES medical_histories(id),
    treatment_id integer NOT NULL REFERENCES treatments(id),
    PRIMARY KEY (medical_history_id, treatment_id)
);

CREATE INDEX ON medical_histories_has_treatments (medical_history_id);

CREATE INDEX ON medical_histories_has_treatments (treatment_id);

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id INT,
    CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE INDEX ON invoices (medical_history_id);

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL,
    quatity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    CONSTRAINT fk_invoices FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    CONSTRAINT fk_treatments FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE INDEX ON invoice_items (invoice_id);

CREATE INDEX ON invoice_items (treatment_id);
