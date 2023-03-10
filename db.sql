CREATE TABLE ZESPOL(
    ID_ZESPOLU CHAR(30) PRIMARY KEY,
    NAZWA CHAR(30) NOT NULL
)

CREATE TABLE ARTYSTA(
    ID CHAR(11) PRIMARY KEY,
	IMIE CHAR(15) NOT NULL DEFAULT 'Jan',
	NAZWISKO CHAR(15) NOT NULL DEFAULT 'Nowak',
	DATA_URODZENIA DATE NOT NULL CHECK( DATA_URODZENIA >= '1904-02-11'),
	NUMER_TELEFONU DECIMAL(9,0) CHECK(NUMER_TELEFONU < 999999999),
	EMAIL CHAR(25) UNIQUE(EMAIL),
    PSEUDONIM CHAR(30) NOT NULL,
    ID_Z CHAR(30) REFERENCES ZESPOL ON UPDATE CASCADE ON DELETE SET NULL
)

CREATE TABLE KLIENT(
    ID CHAR(11) PRIMARY KEY,
	IMIE CHAR(15) NOT NULL DEFAULT 'Jan',
	NAZWISKO CHAR(15) NOT NULL DEFAULT 'Nowak',
	DATA_URODZENIA DATE NOT NULL CHECK( DATA_URODZENIA >= '1904-02-11'),
	NUMER_TELEFONU DECIMAL(9,0) CHECK(NUMER_TELEFONU < 999999999),
	EMAIL CHAR(25) UNIQUE(EMAIL),
    LOGIN CHAR(30) NOT NULL,
    SUBSKRYPCJA CHAR(9) NOT NULL CHECK (SUBSKRYPCJA = N'płatna' OR SUBSKRYPCJA = N'bezpłatna') DEFAULT N'bezpłatna'
)

CREATE TABLE GATUNEK(
    NAZWA CHAR(30) PRIMARY KEY,
    DATA_POWSTANIA DATE NOT NULL
)

CREATE TABLE INSTRUMENT(
    NAZWA CHAR(30) PRIMARY KEY,
    KLASYFIKACJA CHAR(30) NOT NULL
)

CREATE TABLE PRODUCENT(
    NAZWA CHAR(30) PRIMARY KEY,
    ADRES CHAR(30) NOT NULL
)

CREATE TABLE ALBUM(
    ID_ALBUMU CHAR(50) PRIMARY KEY,
    TYTUL CHAR(30) NOT NULL,
    DLUGOSC TIME(0) NOT NULL,
    DATA_WYDANIA DATE NOT NULL,
    NAZWA_G CHAR(30) NOT NULL REFERENCES GATUNEK,
    NAZWA_P CHAR(30) NOT NULL REFERENCES PRODUCENT,
    NAZWA_A CHAR(11) REFERENCES ARTYSTA,
    NAZWA_Z CHAR(30) REFERENCES ZESPOL ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE UTWOR(
    ID_UTWORU CHAR(100) PRIMARY KEY,
    DLUGOSC TIME(0) NOT NULL,
    TYTUL CHAR(30) NOT NULL,
    NUMER_W_ALBUMIE TINYINT NOT NULL,
    ID_A CHAR(50) NOT NULL REFERENCES ALBUM ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE ARTYSTA_INSTRUMENT(
    ID_A CHAR(11) REFERENCES ARTYSTA ON UPDATE CASCADE ON DELETE CASCADE,
    NAZWA CHAR(30) REFERENCES INSTRUMENT,
    PRIMARY KEY (ID_A, NAZWA)
)

CREATE TABLE PLAYLISTA(
    ID_PLAYLISTY CHAR(100) PRIMARY KEY,
    NAZWA CHAR(30) NOT NULL,
    DATA_UTWORZENIA DATE NOT NULL CHECK( DATA_UTWORZENIA >= '2022-12-01' ),
    PRYWATNOSC CHAR(9) NOT NULL CHECK(PRYWATNOSC = 'publiczna' OR PRYWATNOSC = 'prywatna') DEFAULT 'prywatna',
    DLUGOSC TIME(0) NOT NULL,
    ID_K CHAR(11) NOT NULL REFERENCES KLIENT ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE PLAYLISTA_UTWOR(
    ID_P CHAR(100) REFERENCES PLAYLISTA ON UPDATE CASCADE ON DELETE CASCADE,
    ID_U CHAR(100) REFERENCES UTWOR ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY (ID_P, ID_U)
)

CREATE TABLE ODTWORZENIE(
    ID_ODTWORZENIA CHAR(150) PRIMARY KEY,
    DATA DATE NOT NULL CHECK( DATA >= '2022-12-01'),
    URZADZENIE CHAR(30) NOT NULL,
    ID_K CHAR(11) REFERENCES KLIENT ON UPDATE CASCADE ON DELETE SET NULL,
    ID_U CHAR(100) NOT NULL REFERENCES UTWOR ON UPDATE CASCADE ON DELETE CASCADE
)