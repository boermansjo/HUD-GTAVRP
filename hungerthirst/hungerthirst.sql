CREATE TABLE `hungerthirst` (
  `idSteam` varchar(255) NOT NULL,
  `hunger` int(11) NOT NULL DEFAULT '100',
  `thirst` int(11) NOT NULL DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
