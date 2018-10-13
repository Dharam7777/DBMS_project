-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 13, 2018 at 04:35 AM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project3`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Admin_for_operator` (IN `operator_name` VARCHAR(15))  BEGIN
SELECT DISTINCT a.username,a.name  FROM admin a join adds ad on ad.username=a.username join operator o  on o.oid=ad.oid where o.name=operator_name;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFEEDBACK` (IN `given_username` VARCHAR(25))  BEGIN
SELECT *  FROM feedback where username=given_username ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_CUSTOMER` (IN `username` VARCHAR(15), IN `password` VARCHAR(15), IN `email` VARCHAR(25), IN `name` CHAR(20), IN `Balance` DECIMAL(10,2))  BEGIN
DECLARE CONTINUE HANDLER FOR 1062
SELECT CONCAT('duplicate keys (',username,') found') AS error_msg;
INSERT INTO customer values(username,password,email,name,Balance); 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `POST_PRE` (IN `username` VARCHAR(11))  BEGIN
DECLARE VAR1 INT (10);
DECLARE VAR2 INT (10);
DECLARE TYPE1 VARCHAR(10);
DECLARE TYPE2 VARCHAR(10);
 SELECT r.rid into VAR1 from does d join postpaid r on r.rid=d.rid where d.username=username;
 SELECT r.rid into VAR2 from does d join prepaid r on r.rid=d.rid where d.username=username;

IF VAR1!=0 THEN
SET TYPE1="POSTPAID";
END IF;
IF VAR2!=0 THEN
SET TYPE2="PREPAID";
 END IF;
SELECT TYPE1;
SELECT TYPE2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `POST_USERS` (INOUT `POST_USERS` VARCHAR(300))  BEGIN
DECLARE VAR1 varchar(20) DEFAULT "";

DECLARE FINISHED1 INTEGER DEFAULT 0;



DECLARE  CURSOR1 CURSOR FOR 
SELECT d.username  from does d join postpaid r on r.rid=d.rid;


DECLARE CONTINUE HANDLER FOR NOT FOUND SET FINISHED1=TRUE;

OPEN CURSOR1;

LOOP1:LOOP
FETCH CURSOR1 INTO VAR1; 
IF FINISHED1 THEN 
LEAVE LOOP1;
END IF;
SET POST_USERS=CONCAT(VAR1," , ",POST_USERS); 
END LOOP LOOP1;
CLOSE CURSOR1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PRE_USERS` (INOUT `PRE_USERS` VARCHAR(300))  BEGIN

DECLARE VAR2 varchar(20) DEFAULT "";
DECLARE FINISHED2 INTEGER DEFAULT 0;


DECLARE CURSOR2 CURSOR FOR
SELECT d.username  from does d join prepaid r on r.rid=d.rid ;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET FINISHED2=TRUE ;

OPEN CURSOR2;
LOOP2:LOOP
FETCH CURSOR2 INTO VAR2;
IF FINISHED2 THEN 
LEAVE LOOP2;
END IF;
SET PRE_USERS=CONCAT(VAR2," , ",PRE_USERS); 
END LOOP LOOP2;
CLOSE CURSOR2;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_transaction` (IN `id` INT(11))  BEGIN
DECLARE table_not_found condition for 1051;
DECLARE CONTINUE HANDLER FOR table_not_found
SELECT 'please create table first';
SELECT * from transaction_history t where t.tid=tid; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `total_RECHARGE` (IN `dt` DATE)  BEGIN
DECLARE VAR1 INT(100) DEFAULT 0;
SELECT COUNT(tid)  INTO VAR1 FROM transaction_history where R_date=dt;
SELECT VAR1 AS 'TOTAL RECHARGE DONE ON THE GIVEN DATE' ;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `count_recharge` (`oname` VARCHAR(15)) RETURNS INT(10) BEGIN
 DECLARE TOTAL INT(10);
SELECT COUNT(s.oid) as TOTAL_RECHARGE INTO TOTAL from selects s join operator o on o.oid=s.oid WHERE o.name=oname;
RETURN(TOTAL);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `adds`
--

CREATE TABLE `adds` (
  `username` varchar(15) NOT NULL,
  `oid` int(11) NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `adds`
--

INSERT INTO `adds` (`username`, `oid`, `pid`) VALUES
('cbladge2', 1, 1),
('cbladge2', 1, 2),
('clongcake1', 5, 5),
('clongcake1', 5, 8),
('ctrimmingc', 7, 3),
('ctrimmingc', 7, 4),
('vorsman3', 8, 6),
('vorsman3', 8, 7);

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL,
  `password` varchar(15) DEFAULT NULL,
  `name` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `password`, `name`) VALUES
('ahuggina', '2OdtokzyC1kC', 'Ardelia Huggin'),
('bmattiussi5', '0tOOw3bHP', 'Blake Mattiussi'),
('cbladge2', '0LpeUBp', 'Curt Bladge'),
('clongcake1', 'Z1XLFj', 'Clemente Longcake'),
('ctrimmingc', 'Grd95nEwoc', 'Cornall Trimming'),
('fdaskiewicz6', 'a5irErQqRR', 'Fanni Daskiewicz'),
('gdwyer8', 'DEf6jV7bhhP', 'Glenda Dwyer'),
('kmangeonb', 'PBvxerVw1XjJ', 'Kym Mangeon'),
('nmingardi0', 'cZD9MYIGoCSw', 'Newton Mingardi'),
('rheinicke9', 'ToddFbF', 'Ricardo Heinicke'),
('sbygreavesd', 'GqIWOGyDJL3c', 'Serene Bygreaves'),
('scassels4', 'v6h65TE', 'Sigismund Cassels'),
('thanbridge7', 'CUinEjqm', 'Talya Hanbridge'),
('vorsman3', 'sBJg03hhx', 'Verine Orsman'),
('wstuckese', '4tBek89TNat', 'Winna Stuckes');

-- --------------------------------------------------------

--
-- Stand-in structure for view `admin_operator`
-- (See below for the actual view)
--
CREATE TABLE `admin_operator` (
`USERNAME` varchar(20)
,`NAME` char(20)
,`OPERATOR` varchar(15)
,`Description` mediumtext
,`Amount` decimal(6,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `username` varchar(15) NOT NULL,
  `password` varchar(15) NOT NULL,
  `email` varchar(25) NOT NULL,
  `name` char(20) NOT NULL,
  `Balance` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`username`, `password`, `email`, `name`, `Balance`) VALUES
('aniket34', 'anie453', 'aniket@gmail.com', 'aniket', '300.00'),
('dharam777', 'adhsd234', 'dharamshah777@gmail.com', 'dharam', '528.00'),
('dhas2332', 'dlssjdf', 'dahram777@hotmail.com', 'asdffa', '25.00'),
('jainish45', 'jai3434', 'jainishah@gmail.com', 'jainishah', '800.00'),
('jas789', 'ertyew', 'jashah@gmail.com', 'jas', '750.00'),
('kevin7', 'adasjal', 'kevishah@gmail.com', 'kevin', '1000.00'),
('kuldeep999', 'kuldeep1233', 'kuldeeepshah77@gmail.com', 'kuldeep', '1500.00'),
('param342', 'dflkjsdf', 'paramshah999@hotmail.com', 'param', '590.00'),
('parth2', 'adffkhds', 'parthshah@gmail.com', 'parth', '900.00'),
('virti456', 'virti575', 'virtishah775@gmail.com', 'Virti', '600.00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `customer_transaction`
-- (See below for the actual view)
--
CREATE TABLE `customer_transaction` (
`USERNAME` varchar(15)
,`EMAIL` varchar(25)
,`NAME` char(20)
,`OPERATOR` varchar(15)
,`Mob_no` bigint(10)
,`R_date` date
);

-- --------------------------------------------------------

--
-- Table structure for table `data`
--

CREATE TABLE `data` (
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data`
--

INSERT INTO `data` (`pid`) VALUES
(1),
(3),
(6),
(7),
(8);

-- --------------------------------------------------------

--
-- Table structure for table `does`
--

CREATE TABLE `does` (
  `username` varchar(15) NOT NULL,
  `rid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `does`
--

INSERT INTO `does` (`username`, `rid`) VALUES
('aniket34', 2),
('dharam777', 1),
('dhas2332', 3),
('dhas2332', 11),
('jainish45', 4),
('jas789', 6),
('kevin7', 7),
('kuldeep999', 10),
('param342', 8),
('parth2', 5),
('virti456', 9);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `fid` int(11) NOT NULL,
  `username` varchar(15) NOT NULL,
  `Description` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`fid`, `username`, `Description`) VALUES
(1, 'dharam777', 'THIS WAS NICE RECHARGE'),
(2, 'aniket34', 'IT was really nice experience'),
(3, 'jainish45', 'Add more plans for jio'),
(4, 'dhas2332', 'Was really fantastic '),
(5, 'jas789', 'Was very slow process.'),
(6, 'kevin7', 'This very interesting.'),
(7, 'param342', 'Worth project.'),
(8, 'parth2', 'Nice experience.');

-- --------------------------------------------------------

--
-- Table structure for table `mob_no`
--

CREATE TABLE `mob_no` (
  `username` varchar(15) NOT NULL,
  `Mobile1` bigint(10) NOT NULL,
  `Mobile2` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mob_no`
--

INSERT INTO `mob_no` (`username`, `Mobile1`, `Mobile2`) VALUES
('aniket34', 8956748532, 9856458573),
('dharam777', 9852654680, 9429352864),
('dhas2332', 9158963578, 8050256954),
('jainish45', 9825457841, 8595865825),
('jas789', 9428657892, 9856852341),
('kevin7', 9858963621, 7485968547),
('kuldeep999', 9856536521, 9485356235),
('param342', 9429352863, 9756864835),
('parth2', 8256458652, 8745963214),
('virti456', 9825205653, 9409079859);

-- --------------------------------------------------------

--
-- Table structure for table `operator`
--

CREATE TABLE `operator` (
  `oid` int(11) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `site` varchar(20) DEFAULT NULL,
  `logo` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `operator`
--

INSERT INTO `operator` (`oid`, `name`, `site`, `logo`) VALUES
(1, 'Bsnl', 'www.bsnl.co.in', 'bsnl.png'),
(2, 'hutch', 'www.hutch.com', 'hutch.png'),
(3, 'uninor', 'www.uninor.com', 'uninor.png'),
(4, 'vodafone', 'www.vodafone.com', 'vodafone.png'),
(5, 'artiel', 'www.artiel.com', 'artiel.png'),
(6, 'docomo', 'www.docomo.com', 'docomo.png'),
(7, 'idea', 'www.idea.com', 'idea.png'),
(8, 'jio', 'www.jio.com', 'jio.png'),
(9, 'aircel', 'www.aircel.com', 'aircel.png'),
(10, 'videocon', 'www.videocon.com', 'videocon.png');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `pid` int(11) NOT NULL,
  `Description` mediumtext NOT NULL,
  `Amount` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`pid`, `Description`, `Amount`) VALUES
(1, '4G DATA 1GB', '36.00'),
(2, 'TOPUP FOR 200 RS', '200.00'),
(3, '4G DATA 2GB/DAY FOR 1 MONTH', '499.00'),
(4, 'TOPUP UNLIMETED CALLING 3 MONTHS.', '299.00'),
(5, 'FULL TALKTIME.\r\nVALIDITY:Unlimited', '150.00'),
(6, '3GB DATA\r\n28 DAYS', '98.00'),
(7, '6GB DATA \r\nVALIDITY:28 DAYS', '175.00'),
(8, '4G DATA :6GB ,Existing unlimited pack \r\nusers will get validity till unlimited pack \r\nor 7 days whichever is higher.', '98.00'),
(9, 'Full Talktime\r\nValidity:unlimited\r\n', '1000.00');

-- --------------------------------------------------------

--
-- Table structure for table `postpaid`
--

CREATE TABLE `postpaid` (
  `rid` int(11) NOT NULL,
  `Amount` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `postpaid`
--

INSERT INTO `postpaid` (`rid`, `Amount`) VALUES
(1, '100.00'),
(3, '100.00'),
(4, '778.00'),
(5, '89.00'),
(6, '636.00'),
(7, '500.00');

--
-- Triggers `postpaid`
--
DELIMITER $$
CREATE TRIGGER `before_postpaid_insert` BEFORE INSERT ON `postpaid` FOR EACH ROW BEGIN 
DECLARE var2 int(10);

SELECT Balance into var2 from customer c where c.username=any(select d.username from does d join postpaid p on NEW.rid=d.rid  );




if NEW.Amount<=var2 then 
	update customer c set c.Balance=c.Balance-NEW.Amount
	where c.username=any(select d.username from does d join postpaid p on NEW.rid=d.rid ); 
 ELSE
 CALL`"INSUFFICIENT BALANCE"`;
 
 
end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `prepaid`
--

CREATE TABLE `prepaid` (
  `pid` int(11) NOT NULL,
  `rid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `prepaid`
--

INSERT INTO `prepaid` (`pid`, `rid`) VALUES
(1, 1),
(7, 8),
(7, 10),
(8, 9),
(9, 11);

--
-- Triggers `prepaid`
--
DELIMITER $$
CREATE TRIGGER `before_prepaid_insert` AFTER INSERT ON `prepaid` FOR EACH ROW BEGIN 
DECLARE VAR1 int(6);
DECLARE var2 decimal(6,2);
SELECT Balance into VAR1 from customer c where c.username=any(select d.username from does d join prepaid p on NEW.rid=d.rid where p.pid=NEW.pid );
select Amount into var2 from plans p join prepaid pr on NEW.pid=p.pid where pr.rid=NEW.rid;

IF var2<=VAR1  THEN
	UPDATE customer c SET c.Balance=c.Balance-var2
	where c.username=any(select d.username from does d join prepaid p on NEW.rid=d.rid where p.pid=NEW.pid); 
	ELSE
    call`"insuffcient balance"`;
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `recharge`
--

CREATE TABLE `recharge` (
  `rid` int(11) NOT NULL,
  `Mob_no` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recharge`
--

INSERT INTO `recharge` (`rid`, `Mob_no`) VALUES
(1, 9429352864),
(2, 9825205653),
(3, 9426917218),
(4, 8585646429),
(5, 9327182999),
(6, 9429352863),
(7, 9429353062),
(8, 9173536767),
(9, 8585464679),
(10, 8958778845),
(11, 8231794522);

-- --------------------------------------------------------

--
-- Table structure for table `selects`
--

CREATE TABLE `selects` (
  `sid` int(11) NOT NULL,
  `username` varchar(15) NOT NULL,
  `oid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `selects`
--

INSERT INTO `selects` (`sid`, `username`, `oid`) VALUES
(1, 'dharam777', 1),
(2, 'aniket34', 5),
(3, 'dhas2332', 5),
(4, 'jainish45', 8),
(5, 'parth2', 1),
(6, 'kevin7', 7),
(7, 'virti456', 8),
(8, 'kuldeep999', 8),
(9, 'jas789', 7),
(10, 'jas789', 2),
(11, 'param342', 7);

-- --------------------------------------------------------

--
-- Table structure for table `topup`
--

CREATE TABLE `topup` (
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `topup`
--

INSERT INTO `topup` (`pid`) VALUES
(2),
(4),
(5),
(9);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_history`
--

CREATE TABLE `transaction_history` (
  `tid` int(11) NOT NULL,
  `username` varchar(15) NOT NULL,
  `rid` int(11) NOT NULL,
  `oid` int(11) NOT NULL,
  `R_date` date NOT NULL,
  `Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction_history`
--

INSERT INTO `transaction_history` (`tid`, `username`, `rid`, `oid`, `R_date`, `Time`) VALUES
(1, 'dharam777', 1, 1, '2018-09-05', '02:05:12'),
(2, 'aniket34', 2, 5, '2018-09-25', '12:11:03'),
(3, 'dhas2332', 3, 5, '2018-09-02', '09:17:02'),
(5, 'jainish45', 4, 8, '2018-09-05', '16:04:04'),
(6, 'parth2', 5, 1, '2018-02-02', '03:04:02'),
(8, 'kevin7', 7, 7, '2018-05-03', '05:06:02'),
(9, 'param342', 8, 7, '2018-08-15', '15:04:06'),
(10, 'virti456', 9, 8, '2018-07-18', '03:18:07'),
(12, 'kuldeep999', 10, 8, '2018-07-09', '04:14:04'),
(13, 'jas789', 6, 7, '2018-07-18', '08:10:04'),
(14, 'jas789', 11, 2, '2018-06-12', '09:04:04');

-- --------------------------------------------------------

--
-- Structure for view `admin_operator`
--
DROP TABLE IF EXISTS `admin_operator`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `admin_operator`  AS  select `a`.`username` AS `USERNAME`,`a`.`name` AS `NAME`,`o`.`name` AS `OPERATOR`,`p`.`Description` AS `Description`,`p`.`Amount` AS `Amount` from (((`admin` `a` join `adds` `ad` on((`ad`.`username` = `a`.`username`))) join `operator` `o` on((`ad`.`oid` = `o`.`oid`))) join `plans` `p` on((`p`.`pid` = `ad`.`pid`))) ;

-- --------------------------------------------------------

--
-- Structure for view `customer_transaction`
--
DROP TABLE IF EXISTS `customer_transaction`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_transaction`  AS  select `c`.`username` AS `USERNAME`,`c`.`email` AS `EMAIL`,`c`.`name` AS `NAME`,`o`.`name` AS `OPERATOR`,`r`.`Mob_no` AS `Mob_no`,`t`.`R_date` AS `R_date` from (((`customer` `c` join `transaction_history` `t` on((`t`.`username` = `c`.`username`))) join `operator` `o` on((`o`.`oid` = `t`.`oid`))) join `recharge` `r` on((`r`.`rid` = `t`.`rid`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adds`
--
ALTER TABLE `adds`
  ADD PRIMARY KEY (`oid`,`pid`,`username`),
  ADD KEY `pid` (`pid`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `does`
--
ALTER TABLE `does`
  ADD PRIMARY KEY (`rid`),
  ADD KEY `rid` (`rid`),
  ADD KEY `does_ibfk_1` (`username`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`fid`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `mob_no`
--
ALTER TABLE `mob_no`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `operator`
--
ALTER TABLE `operator`
  ADD PRIMARY KEY (`oid`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `postpaid`
--
ALTER TABLE `postpaid`
  ADD PRIMARY KEY (`rid`);

--
-- Indexes for table `prepaid`
--
ALTER TABLE `prepaid`
  ADD PRIMARY KEY (`pid`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `recharge`
--
ALTER TABLE `recharge`
  ADD PRIMARY KEY (`rid`);

--
-- Indexes for table `selects`
--
ALTER TABLE `selects`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `username` (`username`),
  ADD KEY `oid` (`oid`);

--
-- Indexes for table `topup`
--
ALTER TABLE `topup`
  ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `transaction_history`
--
ALTER TABLE `transaction_history`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `rid` (`rid`),
  ADD KEY `oid` (`oid`),
  ADD KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `operator`
--
ALTER TABLE `operator`
  MODIFY `oid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `recharge`
--
ALTER TABLE `recharge`
  MODIFY `rid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `selects`
--
ALTER TABLE `selects`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `transaction_history`
--
ALTER TABLE `transaction_history`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adds`
--
ALTER TABLE `adds`
  ADD CONSTRAINT `adds_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `plans` (`pid`),
  ADD CONSTRAINT `adds_ibfk_2` FOREIGN KEY (`username`) REFERENCES `admin` (`username`),
  ADD CONSTRAINT `adds_ibfk_3` FOREIGN KEY (`oid`) REFERENCES `operator` (`oid`);

--
-- Constraints for table `data`
--
ALTER TABLE `data`
  ADD CONSTRAINT `data_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `plans` (`pid`);

--
-- Constraints for table `does`
--
ALTER TABLE `does`
  ADD CONSTRAINT `does_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`),
  ADD CONSTRAINT `does_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `recharge` (`rid`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`);

--
-- Constraints for table `mob_no`
--
ALTER TABLE `mob_no`
  ADD CONSTRAINT `mob_no_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`);

--
-- Constraints for table `postpaid`
--
ALTER TABLE `postpaid`
  ADD CONSTRAINT `postpaid_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `recharge` (`rid`);

--
-- Constraints for table `prepaid`
--
ALTER TABLE `prepaid`
  ADD CONSTRAINT `prepaid_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `plans` (`pid`),
  ADD CONSTRAINT `prepaid_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `recharge` (`rid`);

--
-- Constraints for table `selects`
--
ALTER TABLE `selects`
  ADD CONSTRAINT `selects_ibfk_1` FOREIGN KEY (`username`) REFERENCES `customer` (`username`),
  ADD CONSTRAINT `selects_ibfk_2` FOREIGN KEY (`oid`) REFERENCES `operator` (`oid`);

--
-- Constraints for table `transaction_history`
--
ALTER TABLE `transaction_history`
  ADD CONSTRAINT `transaction_history_ibfk_1` FOREIGN KEY (`oid`) REFERENCES `operator` (`oid`),
  ADD CONSTRAINT `transaction_history_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `recharge` (`rid`),
  ADD CONSTRAINT `transaction_history_ibfk_3` FOREIGN KEY (`username`) REFERENCES `customer` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
