/*
 Navicat Premium Data Transfer

 Source Server         : MATSERVER 139
 Source Server Type    : MySQL
 Source Server Version : 50737 (5.7.37-log)
 Source Host           : 139.180.154.108:3306
 Source Schema         : nsnradius_schema

 Target Server Type    : MySQL
 Target Server Version : 50737 (5.7.37-log)
 File Encoding         : 65001

 Date: 02/03/2024 23:31:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Function structure for formatbytes
-- ----------------------------
DROP FUNCTION IF EXISTS `formatbytes`;
delimiter ;;
CREATE FUNCTION `formatbytes`(byte BIGINT)
 RETURNS varchar(200) CHARSET utf8mb4
  DETERMINISTIC
BEGIN
  DECLARE bytes VARCHAR(200);
	CASE
		WHEN (byte >= 1099511627776) THEN SET bytes = CONCAT(FORMAT((byte / 1099511627776), 2), 'TB');
		WHEN (byte >= 1073741824) THEN SET bytes = CONCAT(FORMAT((byte / 1073741824), 2), 'GB');
 		WHEN (byte >= 1048576) THEN SET bytes = CONCAT(FORMAT((byte / 1048576), 2), 'MB');
 		WHEN (byte >= 1024) THEN SET bytes = CONCAT(FORMAT((byte / 1024), 2), 'KB');
 		WHEN (byte > 1) THEN SET bytes = CONCAT(FORMAT((byte), 2), 'B');
		ELSE SET bytes = byte;
	END CASE;
	RETURN bytes;
END
;;
delimiter ;


-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'FREFIX_SECRET', 'NSN');
INSERT INTO `config` VALUES (2, 'VPN_SERVER', 'https://vpnidn1.matradius.site/rest');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `urutan` int(11) NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  `separator_id` int(11) NULL DEFAULT NULL,
  `menu` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `related_function` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, 1, 0, 0, 'Dashboard', 'dashboard', 'parent', 'home', 'fa fa-dashboard', NULL);
INSERT INTO `menu` VALUES (2, 2, 0, 0, 'Router', 'router', 'parent', 'router', 'fa fa-server', NULL);
INSERT INTO `menu` VALUES (3, 3, 0, 0, 'Data Penjualan', NULL, 'separator', NULL, NULL, NULL);
INSERT INTO `menu` VALUES (4, 4, 0, 3, 'Hotspot', 'hotspot', 'parent', '#', 'fa fa-wifi', NULL);
INSERT INTO `menu` VALUES (5, 5, 4, 3, 'Profile Hotspot', 'hotspot_profile', 'sub', 'hotspot/profile', 'fa fa-server', NULL);
INSERT INTO `menu` VALUES (6, 6, 4, 3, 'Voucher Hotspot', 'hotspot_voucher', 'sub', 'hotspot/voucher', 'fa fa-server', NULL);

-- ----------------------------
-- Table structure for nas
-- ----------------------------
DROP TABLE IF EXISTS `nas`;
CREATE TABLE `nas`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iduser` int(11) NULL DEFAULT NULL,
  `nasname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `shortname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'other',
  `ports` int(11) NULL DEFAULT NULL,
  `secret` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'secret',
  `server` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `community` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'RADIUS Client',
  `vpnuser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `vpnpassword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `is_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `nasname`(`nasname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nas
-- ----------------------------

-- ----------------------------
-- Table structure for nsn_config_atribut
-- ----------------------------
DROP TABLE IF EXISTS `nsn_config_atribut`;
CREATE TABLE `nsn_config_atribut`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `atribut` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `operator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `tabel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of nsn_config_atribut
-- ----------------------------
INSERT INTO `nsn_config_atribut` VALUES (1, NULL, 'Auth-Type', ':=', 'radgroupcheck');
INSERT INTO `nsn_config_atribut` VALUES (2, 'durasi', 'Max-All-Session', ':=', 'radgroupcheck');
INSERT INTO `nsn_config_atribut` VALUES (3, 'speed', 'Mikrotik-Rate-Limit', ':=', 'radgroupreply');
INSERT INTO `nsn_config_atribut` VALUES (4, 'kuota', 'Max-Data', ':=', 'radgroupcheck');
INSERT INTO `nsn_config_atribut` VALUES (5, 'masaaktif', 'Access-Period', ':=', 'radgroupcheck');
INSERT INTO `nsn_config_atribut` VALUES (6, 'shared', 'Simultaneous-Use', ':=', 'radgroupcheck');
INSERT INTO `nsn_config_atribut` VALUES (7, 'group', 'Mikrotik-Group', '=', 'radgroupreply');

-- ----------------------------
-- Table structure for radacct
-- ----------------------------
DROP TABLE IF EXISTS `radacct`;
CREATE TABLE `radacct`  (
  `radacctid` bigint(20) NOT NULL AUTO_INCREMENT,
  `acctsessionid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `acctuniqueid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `realm` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `nasipaddress` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `nasportid` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `nasporttype` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `acctstarttime` datetime NULL DEFAULT NULL,
  `acctupdatetime` datetime NULL DEFAULT NULL,
  `acctstoptime` datetime NULL DEFAULT NULL,
  `acctinterval` int(11) NULL DEFAULT NULL,
  `acctsessiontime` int(10) UNSIGNED NULL DEFAULT NULL,
  `acctauthentic` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `connectinfo_start` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `connectinfo_stop` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `acctinputoctets` bigint(20) NULL DEFAULT NULL,
  `acctoutputoctets` bigint(20) NULL DEFAULT NULL,
  `calledstationid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `callingstationid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `acctterminatecause` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `servicetype` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `framedprotocol` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `framedipaddress` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `framedipv6address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `framedipv6prefix` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `framedinterfaceid` varchar(44) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `delegatedipv6prefix` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`radacctid`) USING BTREE,
  UNIQUE INDEX `acctuniqueid`(`acctuniqueid`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `framedipaddress`(`framedipaddress`) USING BTREE,
  INDEX `framedipv6address`(`framedipv6address`) USING BTREE,
  INDEX `framedipv6prefix`(`framedipv6prefix`) USING BTREE,
  INDEX `framedinterfaceid`(`framedinterfaceid`) USING BTREE,
  INDEX `delegatedipv6prefix`(`delegatedipv6prefix`) USING BTREE,
  INDEX `acctsessionid`(`acctsessionid`) USING BTREE,
  INDEX `acctsessiontime`(`acctsessiontime`) USING BTREE,
  INDEX `acctstarttime`(`acctstarttime`) USING BTREE,
  INDEX `acctinterval`(`acctinterval`) USING BTREE,
  INDEX `acctstoptime`(`acctstoptime`) USING BTREE,
  INDEX `nasipaddress`(`nasipaddress`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radacct
-- ----------------------------

-- ----------------------------
-- Table structure for radcheck
-- ----------------------------
DROP TABLE IF EXISTS `radcheck`;
CREATE TABLE `radcheck`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `attribute` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `op` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '==',
  `value` varchar(253) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`(32)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radcheck
-- ----------------------------

-- ----------------------------
-- Table structure for radgroupcheck
-- ----------------------------
DROP TABLE IF EXISTS `radgroupcheck`;
CREATE TABLE `radgroupcheck`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `attribute` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `op` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '==',
  `value` varchar(253) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `groupname`(`groupname`(32)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radgroupcheck
-- ----------------------------

-- ----------------------------
-- Table structure for radgroupreply
-- ----------------------------
DROP TABLE IF EXISTS `radgroupreply`;
CREATE TABLE `radgroupreply`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `attribute` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `op` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '=',
  `value` varchar(253) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `groupname`(`groupname`(32)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radgroupreply
-- ----------------------------

-- ----------------------------
-- Table structure for radpostauth
-- ----------------------------
DROP TABLE IF EXISTS `radpostauth`;
CREATE TABLE `radpostauth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `pass` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `reply` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `authdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`(32)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radpostauth
-- ----------------------------

-- ----------------------------
-- Table structure for radreply
-- ----------------------------
DROP TABLE IF EXISTS `radreply`;
CREATE TABLE `radreply`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `attribute` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `op` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '=',
  `value` varchar(253) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`(32)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radreply
-- ----------------------------

-- ----------------------------
-- Table structure for radusergroup
-- ----------------------------
DROP TABLE IF EXISTS `radusergroup`;
CREATE TABLE `radusergroup`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `groupname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `priority` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `username`(`username`(32)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of radusergroup
-- ----------------------------

-- ----------------------------
-- Table structure for sysparam
-- ----------------------------
DROP TABLE IF EXISTS `sysparam`;
CREATE TABLE `sysparam`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sysparam
-- ----------------------------
INSERT INTO `sysparam` VALUES (1, 'ICON_PENDUDUK', 'assets/images/icon/penduduk.png', NULL, NULL);
INSERT INTO `sysparam` VALUES (2, 'ICON_LAKI__LAKI', 'assets/images/icon/male.png', NULL, NULL);
INSERT INTO `sysparam` VALUES (3, 'ICON_PEREMPUAN', 'assets/images/icon/female.png', NULL, NULL);
INSERT INTO `sysparam` VALUES (4, 'ICON_KEPALA_KELUARGA', 'assets/images/icon/kepala_keluarga.png', NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uniqueID` int(11) NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT 0,
  `type` int(11) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telepon` int(11) NULL DEFAULT NULL,
  `organisasi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `alamat_1` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `alamat_2` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `alamat_3` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `provinsi` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `kota` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `penggunaan` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pekerjaan` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10002 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 1992881, 0, 1, 'superadmin', 'Super Admin', 'T3dUM1NYZ0ZZZjJDS2RyUjZTZXNTQT09', NULL, NULL, '', '', '', '', '', '', '', 1, 'Superadmin', '1', '2024-02-27 17:30:42', 99, '2024-02-27 17:30:42', 99);

-- ----------------------------
-- View structure for v_hotspot_profile
-- ----------------------------
DROP VIEW IF EXISTS `v_hotspot_profile`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_hotspot_profile` AS select `a`.`id` AS `id`,`a`.`groupname` AS `groupname`,`b`.`value` AS `shared`,`c`.`value` AS `period`,`d`.`value` AS `rate`,`formatbytes`(`e`.`value`) AS `quota`,`formatbytes`(`f`.`value`) AS `volume`,`g`.`value` AS `times`,`h`.`value` AS `daily`,`i`.`value` AS `ppp` from ((((((((`radgroupcheck` `a` left join `radgroupcheck` `b` on(((`a`.`groupname` = `b`.`groupname`) and (`b`.`attribute` = 'Simultaneous-Use')))) left join `radgroupcheck` `c` on(((`a`.`groupname` = `c`.`groupname`) and (`c`.`attribute` = 'Access-Period')))) left join `radgroupreply` `d` on(((`a`.`groupname` = `d`.`groupname`) and (`d`.`attribute` = 'Mikrotik-Rate-Limit')))) left join `radgroupreply` `e` on(((`a`.`groupname` = `e`.`groupname`) and (`e`.`attribute` = 'Mikrotik-Total-Limit')))) left join `radgroupcheck` `f` on(((`a`.`groupname` = `f`.`groupname`) and (`f`.`attribute` = 'Max-Data')))) left join `radgroupcheck` `g` on(((`a`.`groupname` = `g`.`groupname`) and (`g`.`attribute` = 'Max-All-Session')))) left join `radgroupcheck` `h` on(((`a`.`groupname` = `h`.`groupname`) and (`h`.`attribute` = 'Max-Daily-Session')))) left join `radgroupreply` `i` on(((`a`.`groupname` = `i`.`groupname`) and (`i`.`attribute` = 'Framed-Protocol')))) group by `a`.`groupname`,`b`.`value`,`c`.`value`,`d`.`value`,`e`.`value`,`f`.`value`,`g`.`value`,`h`.`value`,`i`.`value`;

-- ----------------------------
-- View structure for v_hotspot_voucher
-- ----------------------------
DROP VIEW IF EXISTS `v_hotspot_voucher`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_hotspot_voucher` AS select `ra`.`id` AS `id`,`ra`.`username` AS `USERNAME`,`ra`.`value` AS `PASSWORD`,`ra`.`created_at` AS `TANGGAL_PEMBUATAN`,`rug`.`groupname` AS `PROFILE` from (`radcheck` `ra` left join `radusergroup` `rug` on((`ra`.`username` = `rug`.`username`))) where (`ra`.`attribute` = 'Cleartext-Password');

-- ----------------------------
-- View structure for v_voucher_active
-- ----------------------------
DROP VIEW IF EXISTS `v_voucher_active`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_voucher_active` AS select `ra`.`radacctid` AS `id`,`ra`.`username` AS `USERNAME`,`rug`.`groupname` AS `PROFILE`,`ra`.`acctstarttime` AS `START_TIME`,time_format(timediff(now(),`ra`.`acctstarttime`),'%H:%i:%s') AS `UPTIME`,`ra`.`acctinputoctets` AS `UPLOAD`,`ra`.`acctoutputoctets` AS `DOWNLOAD`,`ra`.`nasipaddress` AS `ROUTER`,`ra`.`calledstationid` AS `SERVER`,`ra`.`framedipaddress` AS `IP_ADDRESS`,`ra`.`callingstationid` AS `MAC_ADDRESS` from (`radacct` `ra` left join `radusergroup` `rug` on((`ra`.`username` = `rug`.`username`))) where isnull(`ra`.`acctstoptime`);


SET FOREIGN_KEY_CHECKS = 1;
