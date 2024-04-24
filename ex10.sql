--2 e 3:

CREATE TABLE Filme (
    IDFilme INT PRIMARY KEY,
    Nome VARCHAR(30),
    Duracao INT,
    Categoria VARCHAR(13)
);

CREATE TABLE Ator (
    IDAtor INT PRIMARY KEY,
    Ator VARCHAR(20),
    Cache SMALLINT,
    Produtora VARCHAR(100)
);

CREATE TABLE TipoParticipacao (
    IDTipo INT PRIMARY KEY,
    Tipo VARCHAR(30)
);

CREATE TABLE Filme_Ator (
    IDFilme INT,
    IDAtor INT,
    IDTipo INT,
    FOREIGN KEY (IDFilme) REFERENCES Filme(IDFilme),
    FOREIGN KEY (IDAtor) REFERENCES Ator(IDAtor),
    FOREIGN KEY (IDTipo) REFERENCES TipoParticipacao(IDTipo),
    PRIMARY KEY (IDFilme, IDAtor)
);

--4

INSERT INTO Filme (IDFilme, Nome, Duracao, Categoria) VALUES
(1, 'Xuxa e os duendes', 180, 'Infantil'),
(2, 'Super-Homem', 200, 'Aventura'),
(3, 'Senhor dos Anéis', 450, 'Ficção'),
(4, 'Triplo X', 180, 'Ação'),
(5, 'A procura de Nemo', 180, 'Infantil'),
(6, 'Connan', 300, 'Ação');


INSERT INTO TipoParticipacao (IDTipo, Tipo) VALUES
(1, 'Ator Principal'),
(2, 'Ator Secundário'),
(3, 'Figurante'),
(4, 'Duble'),
(5, 'Participação Especial');


INSERT INTO Ator (IDAtor, Ator, Cache, Produtora) VALUES
(1, 'Tom Hanks', 20000, 'Universal Pictures'),
(2, 'Meryl Streep', 15000, 'Warner Bros.'),
(3, 'Leonardo DiCaprio', 25000, 'Paramount Pictures'),
(4, 'Jennifer Lawrence', 18000, '20th Century Studios'),
(5, 'Robert Downey Jr.', 13000, 'Marvel Studios'),
(6, 'Angelina Jolie', 22000, 'Columbia Pictures'),
(7, 'Will Smith', 28000, 'Sony Pictures'),
(8, 'Scarlett Johansson', 27000, 'Disney');

--5

INSERT INTO Filme_Ator(IDFilme, IDAtor, IDTipo) VALUES
(1, 1, 1), 
(1, 2, 2), 
(2, 5, 1), 
(2, 6, 2), 
(3, 3, 1), 
(3, 4, 2), 
(4, 5, 1), 
(4, 7, 2), 
(5, 1, 1), 
(5, 8, 2), 
(6, 6, 1),
(6, 7, 2); 

--6
UPDATE Filme
SET Duracao = 200
WHERE IDFilme = 4;

--7
UPDATE Filme
SET Categoria = 'Aventura'
WHERE IDFilme = 6;

--8
DELETE FROM Filme_Ator
WHERE IDTipo = 2;

DELETE FROM TipoParticipacao
WHERE IDTipo = 2;

--9
DELETE FROM Filme
WHERE Duracao > 410;

--10
CREATE TABLE Controle_Exclusao (
    IDExclusao INT IDENTITY(1,1) PRIMARY KEY,
    IDFilme INT,
    IDAtor INT,
    IDTipo INT
);

--11
CREATE TRIGGER tgr_monitora_filme_ator
ON Filme_Ator
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Controle_Exclusao (IDFilme, IDAtor, IDTipo)
    SELECT deleted.IDFilme, deleted.IDAtor, deleted.IDTipo
    FROM deleted;
END;

select * from Filme

select * from TipoParticipacao

select * from Ator

select * from Filme_Ator






