# Host: localhost  (Version 5.5.53)
# Date: 2018-08-13 10:59:08
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "poem_author"
#

DROP TABLE IF EXISTS `poem_author`;
CREATE TABLE `poem_author` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `author_name` varchar(255) DEFAULT NULL COMMENT '诗人名称',
  `author_info` text COMMENT '诗人简介',
  `author_dynasty` varchar(255) NOT NULL DEFAULT '' COMMENT '作者朝代',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Data for table "poem_author"
#

/*!40000 ALTER TABLE `poem_author` DISABLE KEYS */;
INSERT INTO `poem_author` VALUES (1,'李白','李白（701年－762年） ，字太白，号青莲居士，又号“谪仙人”，是唐代伟大的浪漫主义诗人，被后人誉为“诗仙”，与杜甫并称为“李杜”，为了与另两位诗人李商隐与杜牧即“小李杜”区别，杜甫与李白又合称“大李杜”。据《新唐书》记载，李白为兴圣皇帝（凉武昭王李暠）九世孙，与李唐诸王同宗。其人爽朗大方，爱饮酒作诗，喜交友。','唐'),(2,'杜甫','杜甫（712年—770年），字子美，汉族，原籍湖北襄阳，后徙河南巩县。 [1-2]  自号少陵野老，唐代伟大的现实主义诗人，与李白合称“李杜”。为了与另两位诗人李商隐与杜牧即“小李杜”区别，杜甫与李白又合称“大李杜”，杜甫也常被称为“老杜”','唐'),(4,'李白','白居易（772年－846年），字乐天，号香山居士，又号醉吟先生，祖籍太谷 ，到其曾祖父时迁居下邽，生于河南新郑。 是唐代伟大的现实主义诗人，唐代三大诗人之一。白居易与元稹共同倡导新乐府运动，世称“元白”，与刘禹锡并称“刘白','唐'),(5,'苏轼','苏轼（1037年1月8日—1101年8月24日），字子瞻，又字和仲，号铁冠道人、东坡居士，世称苏东坡、苏仙   。汉族，眉州眉山（今属四川省眉山市）人，祖籍河北栾城，北宋文学家、书法家、画家 。','北宋'),(6,'李清照','李清照（1084年3月13日—约1155年），号易安居士，汉族，齐州济南（今山东省济南市章丘区）人。宋代女词人，婉约词派代表，有“千古第一才女”之称。','北宋'),(7,'杜牧','杜牧（803年－约852年），字牧之，号樊川居士，汉族，京兆万年（今陕西西安）人。杜牧是唐代杰出的诗人、散文家，是宰相杜佑之孙，杜从郁之子。唐文宗大和二年26岁中进士，授弘文馆校书郎。后赴江西观察使幕，转淮南节度使幕，又入观察使幕，理人国史馆修撰，膳部、比部、司勋员外郎，黄州、池州、睦州刺史等职','唐'),(8,'刘禹锡','刘禹锡（772年—842年），字梦得，河南洛阳人，自称“家本荥上，籍占洛阳”  ，又自言系出中山。其先为中山靖王刘胜。唐朝文学家、哲学家，有“诗豪” [4]  之称。','唐');
/*!40000 ALTER TABLE `poem_author` ENABLE KEYS */;

#
# Structure for table "poem_info"
#

DROP TABLE IF EXISTS `poem_info`;
CREATE TABLE `poem_info` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '诗词题目',
  `content` text NOT NULL COMMENT '诗词内容',
  `authorId` int(11) DEFAULT NULL COMMENT '诗词作者',
  `poem_produce` text COMMENT '诗词描述/背景',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Data for table "poem_info"
#

/*!40000 ALTER TABLE `poem_info` DISABLE KEYS */;
INSERT INTO `poem_info` VALUES (4,'登楼','花近高楼伤客心，万方多难此登临。\n锦江春色来天地，玉垒浮云变古今。\n北极朝廷终不改，西山寇盗莫相侵。\n可怜后主还祠庙，日暮聊为梁甫吟。',2,'　这首诗写于成都，时在代宗广德二年（764）春，诗人客蜀已是第五个年头。上年正月，官军收复河南河北，安史之乱平定；十月便有吐蕃陷长安、立傀儡、改年号，代宗奔陕州事；随后郭子仪复京师，乘舆反正；年底吐蕃又破松、维、保等州（在今四川北部），继而再陷剑南、西山诸州。诗中“西山寇盗”即指吐蕃；“万方多难”也以吐蕃入侵为最烈，同时，也指宦官专权、藩镇割据、朝廷内外交困、灾患重重的日益衰败景象。'),(5,'春夜洛城闻笛','谁家玉笛暗飞声，散入春风满洛城。\n此夜曲中闻折柳，何人不起故园情。',1,'洛城就是现在河南的洛阳，在唐代是一个很繁华的都市，称为东都。一个春风骀荡的夜晚，万家灯火渐渐熄灭，白日的喧嚣早已平静下来。忽然传来嘹亮的笛声，凄清婉转的曲调随着春风飞呀，飞呀，飞遍了整个洛城。这时有一个远离家乡的诗人还没入睡，他倚窗独立，眼望着“白玉盘”似的明月，耳听着远处的笛声，陷入了沉思。笛子吹奏的是一支《折杨柳》曲，它属于汉乐府古曲，抒写离别行旅之苦。古代离别的时候，往往从路边折柳枝相送；杨柳依依，正好借以表达恋恋不舍的心情。在这样一个春天的晚上，听着这样一支饱含离愁别绪的曲子，谁能不起思乡之情呢？于是，诗人情不自禁地吟了这首七绝。');
/*!40000 ALTER TABLE `poem_info` ENABLE KEYS */;

#
# Structure for table "yulu_info"
#

DROP TABLE IF EXISTS `yulu_info`;
CREATE TABLE `yulu_info` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `typeId` int(11) NOT NULL DEFAULT '0',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

#
# Data for table "yulu_info"
#

/*!40000 ALTER TABLE `yulu_info` DISABLE KEYS */;
INSERT INTO `yulu_info` VALUES (3,'通常愿意留下来跟你争吵的人，才是真正爱你的人!',2,'01.jpg'),(4,' 千万别等到人人都说你丑时才发现自己真的丑。',2,'01.jpg'),(5,'有的人走了就再也没回来过，所以，等待和犹豫才是这个世界上最无情的杀手！',3,'01.jpg'),(6,'踮起脚尖，我们就能离幸福更近一点吗？',3,'01.jpg'),(7,'你一定要分清，他偶遇时的关心不是余情未了，而是出于礼貌。',4,'01.jpg'),(8,'有时候，你必须放手，才能明白是否它真的值得你拥有。',4,'01.jpg'),(17,'因为你，我懂得了爱。爱情是生活最好的提神剂。爱情永不死。有了你，黑暗不再是黑暗。',1,'l4.de7d51e.jpg'),(18,'于千万人之中遇见你所要遇见的人，于千万年之中，时间的无涯的荒野里，没有早一步，也没有晚一步，刚巧赶上了，那也没有别的话可说，惟有轻轻地问一声：“噢，你也在这里吗？”',3,'l4.de7d51e.jpg'),(19,'有一些人，这辈子都不会在一起，但是有一种感觉却可以藏在心里，守一辈子。',1,'banner_1.dfe58d1.png'),(20,'不要看我俗，那是代表我诚心，不要看我笨，那是代表我对你真心，不要看我傻，那是因为爱上你之后，不要看我帅，那是因为在你的心里我就是最帅的！',1,'l8.5221afc.jpg');
/*!40000 ALTER TABLE `yulu_info` ENABLE KEYS */;

#
# Structure for table "yulu_type"
#

DROP TABLE IF EXISTS `yulu_type`;
CREATE TABLE `yulu_type` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "yulu_type"
#

/*!40000 ALTER TABLE `yulu_type` DISABLE KEYS */;
INSERT INTO `yulu_type` VALUES (1,'爱情语录'),(2,'经典搞笑语录'),(3,'名人语录'),(4,'人生感悟');
/*!40000 ALTER TABLE `yulu_type` ENABLE KEYS */;
