CREATE TABLE usuarios (
        cod_usuario     SERIAL  NOT NULL,
        usuario                 varchar(10) NOT NULL,
        nome                    varchar(50) NOT NULL,
        telefone                varchar(15) NOT NULL,
        email                   varchar(50) NOT NULL,
        PRIMARY KEY (cod_usuario)
);

INSERT INTO usuarios (usuario, nome, telefone, email) VALUES
        ('difusao', 'Geovani José Malaquias', '32988554410', 'difusao@gmail.com'),
        ('maria',       'Maria AParecida', '3298564712', 'maria@gmail.com'),
        ('rosa',        'Rosa Maria', '3265987412', 'rosa@gmail.com'),
        ('paulo',       'Paulo Souza', '3214587932', 'paulo@gmail.com'),
        ('carlos',      'Carlos Antônio', '3298653214', 'carlos@gmail.com'),
        ('ana',         'Ana Paula', '3265987410', 'ana@gmail.com'),
        ('silvia',      'Silvia Cardozo', '3214253698', 'silvia@gmail.com'),
        ('pedro',       'Pedro Souza', '3265987416', 'pedro@gmail.com'),
        ('lucia',       'Lucia Pereira', '3212457896', 'lucia@gmail.com'),
        ('eduardo', 'Educardo Campos', '3214253678', 'eduardo@gmail.com');