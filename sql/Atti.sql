--
-- Struttura della tabella `Atti`
--

CREATE TABLE IF NOT EXISTS `Atti` (
  `idAtto` int(11) DEFAULT NULL,
  `NumAtto1` varchar(255) DEFAULT NULL,
  `NumAtto2` varchar(255) DEFAULT NULL,
  `NumAtto1Kine` varchar(255) DEFAULT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `Cognome` varchar(255) DEFAULT NULL,
  `Nome` varchar(255) DEFAULT NULL,
  `cfpi` varchar(255) DEFAULT NULL,
  `datadom` varchar(255) DEFAULT NULL,
  `Protocollo` varchar(255) DEFAULT NULL,
  `dataprovv` varchar(255) DEFAULT NULL,
  `rilasciata` varchar(255) DEFAULT NULL,
  `desclavori` varchar(255) DEFAULT NULL,
  `particella` varchar(255) DEFAULT NULL,
  `EdFond` varchar(255) DEFAULT NULL,
  `PorzMat` varchar(255) DEFAULT NULL,
  `Sub` varchar(255) NOT NULL,
  `ComCat` varchar(255) NOT NULL,
  `Localita` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;