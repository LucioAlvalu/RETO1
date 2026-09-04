CREATE TABLE IF NOT EXISTS startups (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    founded_at DATE NOT NULL, 
    location VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL, 
    funding_amount NUMERIC(15, 2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS technologies (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(255) NOT NULL,
    sector VARCHAR(100) NOT NULL,
    description TEXT,
    adoption_level VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- datos iniciales para prueba
INSERT INTO startups (name, founded_at, location, category, funding_amount) VALUES
('OpenAI Ventures', '2018-03-20', 'Ciudad de México', 'AI', 2500000.00),
('Kuspit Tech', '2020-01-15', 'Guadalajara', 'Fintech', 1200000.00);

INSERT INTO technologies (name, sector, description, adoption_level) VALUES 
('Computer Vision', 'Healthcare', 'Tecnología para análisis de imágenes médicas', 'high'),
('NLP Processors', 'Finance', 'Procesamiento de lenguaje natural para finanzas', 'medium');
