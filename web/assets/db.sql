-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.9-MariaDB


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema rat_trap
--

CREATE DATABASE IF NOT EXISTS rat_trap;
USE rat_trap;

--
-- Definition of table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `address` text,
  `mobile` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;


--
-- Definition of table `details`
--

DROP TABLE IF EXISTS `details`;
CREATE TABLE `details` (
  `iddetails` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `tp` varchar(45) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `domain` varchar(45) DEFAULT NULL,
  `image` text,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`iddetails`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `details`
--

/*!40000 ALTER TABLE `details` DISABLE KEYS */;
INSERT INTO `details` (`iddetails`,`name`,`address`,`fax`,`tp`,`email`,`domain`,`image`,`status`) VALUES 
 (1,'Rat trap ','Mawanella','0661212452','0665252145','lahiruariya@gmail.com','n/a','n/a',1);
/*!40000 ALTER TABLE `details` ENABLE KEYS */;


--
-- Definition of table `grn`
--

DROP TABLE IF EXISTS `grn`;
CREATE TABLE `grn` (
  `grn_id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL,
  `total` double DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `net_total` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`grn_id`),
  KEY `fk_grn_user1_idx` (`user_id`),
  KEY `fk_grn_supplier1_idx` (`supplier_id`),
  CONSTRAINT `fk_grn_supplier1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grn_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grn`
--

/*!40000 ALTER TABLE `grn` DISABLE KEYS */;
/*!40000 ALTER TABLE `grn` ENABLE KEYS */;


--
-- Definition of table `grn_cheque_details`
--

DROP TABLE IF EXISTS `grn_cheque_details`;
CREATE TABLE `grn_cheque_details` (
  `grn_cheque_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `grn_payment_id` int(11) NOT NULL,
  `type` varchar(45) DEFAULT NULL COMMENT 'Cash Cheque\nDate Cheque',
  `cheque_no` varchar(45) DEFAULT NULL,
  `cheque_date` varchar(45) DEFAULT NULL,
  `bank` varchar(45) DEFAULT NULL,
  `branch` varchar(45) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`grn_cheque_details_id`),
  KEY `fk_cheque_details_grn_payment1_idx` (`grn_payment_id`),
  CONSTRAINT `fk_cheque_details_grn_payment1` FOREIGN KEY (`grn_payment_id`) REFERENCES `grn_payment` (`grn_payment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grn_cheque_details`
--

/*!40000 ALTER TABLE `grn_cheque_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `grn_cheque_details` ENABLE KEYS */;


--
-- Definition of table `grn_item`
--

DROP TABLE IF EXISTS `grn_item`;
CREATE TABLE `grn_item` (
  `grn_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `grn_id` int(11) NOT NULL,
  `raw_items_id` int(11) NOT NULL,
  `unit_price` double DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `net_total` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`grn_item_id`),
  KEY `fk_grn_item_raw_items1_idx` (`raw_items_id`),
  KEY `fk_grn_item_grn1_idx` (`grn_id`),
  CONSTRAINT `fk_grn_item_grn1` FOREIGN KEY (`grn_id`) REFERENCES `grn` (`grn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grn_item_raw_items1` FOREIGN KEY (`raw_items_id`) REFERENCES `raw_items` (`raw_items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grn_item`
--

/*!40000 ALTER TABLE `grn_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `grn_item` ENABLE KEYS */;


--
-- Definition of table `grn_payment`
--

DROP TABLE IF EXISTS `grn_payment`;
CREATE TABLE `grn_payment` (
  `grn_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `grn_id` int(11) NOT NULL,
  `payment_type_id` int(11) NOT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`grn_payment_id`),
  KEY `fk_grn_payment_grn1_idx` (`grn_id`),
  KEY `fk_grn_payment_payment_type1_idx` (`payment_type_id`),
  CONSTRAINT `fk_grn_payment_grn1` FOREIGN KEY (`grn_id`) REFERENCES `grn` (`grn_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grn_payment_payment_type1` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grn_payment`
--

/*!40000 ALTER TABLE `grn_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `grn_payment` ENABLE KEYS */;


--
-- Definition of table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL AUTO_INCREMENT,
  `total` double DEFAULT NULL,
  `cash` double DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `net_total` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `fk_invoice_customer1_idx` (`customer_id`),
  KEY `fk_invoice_user1_idx` (`user_id`),
  CONSTRAINT `fk_invoice_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice`
--

/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;


--
-- Definition of table `invoice_cheque_details`
--

DROP TABLE IF EXISTS `invoice_cheque_details`;
CREATE TABLE `invoice_cheque_details` (
  `invoice_cheque_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_payment_id` int(11) NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `cheque_no` varchar(45) DEFAULT NULL,
  `cheque_date` varchar(45) DEFAULT NULL,
  `bank` varchar(45) DEFAULT NULL,
  `branch` varchar(45) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoice_cheque_details_id`),
  KEY `fk_invoice_cheque_details_invoice_payment1_idx` (`invoice_payment_id`),
  CONSTRAINT `fk_invoice_cheque_details_invoice_payment1` FOREIGN KEY (`invoice_payment_id`) REFERENCES `invoice_payment` (`invoice_payment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice_cheque_details`
--

/*!40000 ALTER TABLE `invoice_cheque_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_cheque_details` ENABLE KEYS */;


--
-- Definition of table `invoice_item`
--

DROP TABLE IF EXISTS `invoice_item`;
CREATE TABLE `invoice_item` (
  `invoice_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `stock_id` int(11) NOT NULL,
  `cost` double DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `net_total` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoice_item_id`),
  KEY `fk_invoice_item_invoice_idx` (`invoice_id`),
  KEY `fk_invoice_item_stock1_idx` (`stock_id`),
  CONSTRAINT `fk_invoice_item_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_item_stock1` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice_item`
--

/*!40000 ALTER TABLE `invoice_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_item` ENABLE KEYS */;


--
-- Definition of table `invoice_payment`
--

DROP TABLE IF EXISTS `invoice_payment`;
CREATE TABLE `invoice_payment` (
  `invoice_payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `payment_type_id` int(11) NOT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoice_payment_id`),
  KEY `fk_invoice_payment_invoice1_idx` (`invoice_id`),
  KEY `fk_invoice_payment_payment_type1_idx` (`payment_type_id`),
  CONSTRAINT `fk_invoice_payment_invoice1` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_invoice_payment_payment_type1` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_type` (`payment_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice_payment`
--

/*!40000 ALTER TABLE `invoice_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_payment` ENABLE KEYS */;


--
-- Definition of table `item_staff_cost`
--

DROP TABLE IF EXISTS `item_staff_cost`;
CREATE TABLE `item_staff_cost` (
  `item_staff_cost_id` int(11) NOT NULL AUTO_INCREMENT,
  `items_id` int(11) NOT NULL,
  `production_steps_id` int(11) NOT NULL,
  `cost` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_staff_cost_id`),
  KEY `fk_item_staff_cost_items1_idx` (`items_id`),
  KEY `fk_item_staff_cost_production_steps1_idx` (`production_steps_id`),
  CONSTRAINT `fk_item_staff_cost_items1` FOREIGN KEY (`items_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_staff_cost_production_steps1` FOREIGN KEY (`production_steps_id`) REFERENCES `production_steps` (`production_steps_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `item_staff_cost`
--

/*!40000 ALTER TABLE `item_staff_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_staff_cost` ENABLE KEYS */;


--
-- Definition of table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `items_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `image` text,
  `ROL` double DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `measurement_type_id` int(11) NOT NULL,
  PRIMARY KEY (`items_id`),
  KEY `fk_items_measurement_type1_idx` (`measurement_type_id`),
  CONSTRAINT `fk_items_measurement_type1` FOREIGN KEY (`measurement_type_id`) REFERENCES `measurement_type` (`measurement_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items`
--

/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;


--
-- Definition of table `items_has_raw_items`
--

DROP TABLE IF EXISTS `items_has_raw_items`;
CREATE TABLE `items_has_raw_items` (
  `items_has_raw_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `items_id` int(11) NOT NULL,
  `raw_items_id` int(11) NOT NULL,
  `amount` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`items_has_raw_items_id`),
  KEY `fk_items_has_raw_items_raw_items1_idx` (`raw_items_id`),
  KEY `fk_items_has_raw_items_items1_idx` (`items_id`),
  CONSTRAINT `fk_items_has_raw_items_items1` FOREIGN KEY (`items_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_items_has_raw_items_raw_items1` FOREIGN KEY (`raw_items_id`) REFERENCES `raw_items` (`raw_items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `items_has_raw_items`
--

/*!40000 ALTER TABLE `items_has_raw_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_has_raw_items` ENABLE KEYS */;


--
-- Definition of table `job_roll`
--

DROP TABLE IF EXISTS `job_roll`;
CREATE TABLE `job_roll` (
  `job_roll_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`job_roll_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `job_roll`
--

/*!40000 ALTER TABLE `job_roll` DISABLE KEYS */;
INSERT INTO `job_roll` (`job_roll_id`,`name`,`status`) VALUES 
 (1,'System User',1);
/*!40000 ALTER TABLE `job_roll` ENABLE KEYS */;


--
-- Definition of table `measurement_type`
--

DROP TABLE IF EXISTS `measurement_type`;
CREATE TABLE `measurement_type` (
  `measurement_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`measurement_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `measurement_type`
--

/*!40000 ALTER TABLE `measurement_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `measurement_type` ENABLE KEYS */;


--
-- Definition of table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
CREATE TABLE `payment_type` (
  `payment_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`payment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment_type`
--

/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;


--
-- Definition of table `production`
--

DROP TABLE IF EXISTS `production`;
CREATE TABLE `production` (
  `production_id` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `sale_price` double DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `total_labour_cost` double DEFAULT NULL,
  `company_cost` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `items_items_id` int(11) NOT NULL,
  PRIMARY KEY (`production_id`),
  KEY `fk_production_items1_idx` (`items_items_id`),
  CONSTRAINT `fk_production_items1` FOREIGN KEY (`items_items_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `production`
--

/*!40000 ALTER TABLE `production` DISABLE KEYS */;
/*!40000 ALTER TABLE `production` ENABLE KEYS */;


--
-- Definition of table `production_raw_items`
--

DROP TABLE IF EXISTS `production_raw_items`;
CREATE TABLE `production_raw_items` (
  `production_raw_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `production_id` int(11) NOT NULL,
  `raw_items_id` int(11) NOT NULL,
  `total` double DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `tota_cost` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`production_raw_items_id`),
  KEY `fk_production_raw_items_raw_items1_idx` (`raw_items_id`),
  KEY `fk_production_raw_items_production1_idx` (`production_id`),
  CONSTRAINT `fk_production_raw_items_production1` FOREIGN KEY (`production_id`) REFERENCES `production` (`production_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_production_raw_items_raw_items1` FOREIGN KEY (`raw_items_id`) REFERENCES `raw_items` (`raw_items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `production_raw_items`
--

/*!40000 ALTER TABLE `production_raw_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_raw_items` ENABLE KEYS */;


--
-- Definition of table `production_staff`
--

DROP TABLE IF EXISTS `production_staff`;
CREATE TABLE `production_staff` (
  `production_staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `production_id` int(11) NOT NULL,
  `production_steps_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `cost` double DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`production_staff_id`),
  KEY `fk_production_staff_production1_idx` (`production_id`),
  KEY `fk_production_staff_production_steps1_idx` (`production_steps_id`),
  KEY `fk_production_staff_staff1_idx` (`staff_id`),
  CONSTRAINT `fk_production_staff_production1` FOREIGN KEY (`production_id`) REFERENCES `production` (`production_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_production_staff_production_steps1` FOREIGN KEY (`production_steps_id`) REFERENCES `production_steps` (`production_steps_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_production_staff_staff1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `production_staff`
--

/*!40000 ALTER TABLE `production_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_staff` ENABLE KEYS */;


--
-- Definition of table `production_steps`
--

DROP TABLE IF EXISTS `production_steps`;
CREATE TABLE `production_steps` (
  `production_steps_id` int(11) NOT NULL AUTO_INCREMENT,
  `items_id` int(11) NOT NULL,
  `step_name` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`production_steps_id`),
  KEY `fk_production_steps_items1_idx` (`items_id`),
  CONSTRAINT `fk_production_steps_items1` FOREIGN KEY (`items_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `production_steps`
--

/*!40000 ALTER TABLE `production_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `production_steps` ENABLE KEYS */;


--
-- Definition of table `raw_items`
--

DROP TABLE IF EXISTS `raw_items`;
CREATE TABLE `raw_items` (
  `raw_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `image` text,
  `ROL` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `measurement_type_id` int(11) NOT NULL,
  PRIMARY KEY (`raw_items_id`),
  KEY `fk_raw_items_measurement_type1_idx` (`measurement_type_id`),
  CONSTRAINT `fk_raw_items_measurement_type1` FOREIGN KEY (`measurement_type_id`) REFERENCES `measurement_type` (`measurement_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `raw_items`
--

/*!40000 ALTER TABLE `raw_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `raw_items` ENABLE KEYS */;


--
-- Definition of table `raw_stock`
--

DROP TABLE IF EXISTS `raw_stock`;
CREATE TABLE `raw_stock` (
  `raw_stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `raw_items_id` int(11) NOT NULL,
  `cost` double DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  PRIMARY KEY (`raw_stock_id`),
  KEY `fk_raw_stock_raw_items1_idx` (`raw_items_id`),
  CONSTRAINT `fk_raw_stock_raw_items1` FOREIGN KEY (`raw_items_id`) REFERENCES `raw_items` (`raw_items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `raw_stock`
--

/*!40000 ALTER TABLE `raw_stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `raw_stock` ENABLE KEYS */;


--
-- Definition of table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `nic` varchar(45) DEFAULT NULL,
  `address` text,
  `job_roll_id` int(11) NOT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `fk_staff_job_roll1_idx` (`job_roll_id`),
  CONSTRAINT `fk_staff_job_roll1` FOREIGN KEY (`job_roll_id`) REFERENCES `job_roll` (`job_roll_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `staff`
--

/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` (`staff_id`,`name`,`mobile`,`nic`,`address`,`job_roll_id`) VALUES 
 (1,'mayura Lakshan Ariyadasa','0702525145','960101278v','Dambulla',1);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;


--
-- Definition of table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `items_id` int(11) NOT NULL,
  `cost` double DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  `time` varchar(45) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `price` double DEFAULT NULL,
  PRIMARY KEY (`stock_id`),
  KEY `fk_stock_items1_idx` (`items_id`),
  CONSTRAINT `fk_stock_items1` FOREIGN KEY (`items_id`) REFERENCES `items` (`items_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock`
--

/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;


--
-- Definition of table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `address` text,
  `tele` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplier`
--

/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `staff_id` int(11) NOT NULL,
  `sales` varchar(45) DEFAULT NULL,
  `purchase` varchar(45) DEFAULT NULL,
  `production` varchar(45) DEFAULT NULL,
  `create` varchar(45) DEFAULT NULL,
  `user` varchar(45) DEFAULT NULL,
  `cheque` varchar(45) DEFAULT NULL,
  `report` varchar(45) DEFAULT NULL,
  `other` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_staff1_idx` (`staff_id`),
  CONSTRAINT `fk_user_staff1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`,`username`,`password`,`status`,`staff_id`,`sales`,`purchase`,`production`,`create`,`user`,`cheque`,`report`,`other`) VALUES 
 (1,'admin','1234',1,1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ','ABCDEFGHIJKLMNOPQRSTUVWXYZ');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
