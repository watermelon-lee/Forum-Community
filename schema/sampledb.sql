DROP DATABASE IF EXISTS sampledb;
CREATE DATABASE sampledb DEFAULT CHARACTER SET utf8;
USE sampledb;


/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016-10-3 0:34:13                             */
/*==============================================================*/


drop table if exists t_board;

drop table if exists t_board_manager;

drop table if exists t_post;

drop table if exists t_topic;

drop table if exists t_user;

drop table if exists t_login_log;

CREATE TABLE `t_board` (
  `board_id` int(11) NOT NULL auto_increment COMMENT '论坛版块ID',
  `board_name` varchar(150) NOT NULL default '' COMMENT '论坛版块名',
  `board_desc` varchar(255) default NULL COMMENT '论坛版块描述',
  `topic_num` int(11) NOT NULL default '0' COMMENT '帖子数目',
  PRIMARY KEY  (`board_id`),
  KEY `AK_Board_NAME` (`board_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#key是为表添加索引，索引的作用是增加数据库的查询速度。MySQL的数据库引擎是InnoDB，它采用B+树和哈希两种数据结构的方式为表添加索引。
#
# Dumping data for table t_board
#

INSERT INTO `t_board` VALUES (1,'SpringMVC','Spring 框架提供了构建 Web 应用程序的全功能 MVC 模块\r\n',8);
INSERT INTO `t_board` VALUES (2,'\r\nSpring Boot','简化新Spring应用的初始搭建以及开发过程，让我们一起来深入这个领域吧',0);
INSERT INTO `t_board` VALUES (3,'Spring 事务管理','本板块将讨论 Spring 庞杂而强大的事务功能,包括编程式事务和声明式事务 ',0);
INSERT INTO `t_board` VALUES (4,' IOC和AOP ','IOC和AOP讨论板块',3);
INSERT INTO `t_board` VALUES (7,'dddddddddddd','ddddddddddddddddddddddddddddddd',0);
INSERT INTO `t_board` VALUES (8,'SpringMVC','SpringMVC经验~~',0);

#
# Source for table t_board_manager
#

CREATE TABLE `t_board_manager` (
  `board_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`board_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='论坛管理员';

#
# Dumping data for table t_board_manager
#

INSERT INTO `t_board_manager` VALUES (1,1);
INSERT INTO `t_board_manager` VALUES (1,2);
INSERT INTO `t_board_manager` VALUES (5,2);
INSERT INTO `t_board_manager` VALUES (5,3);

#
# Source for table t_login_log
#

CREATE TABLE `t_login_log` (
  `login_log_id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `ip` varchar(30) NOT NULL default '',
  `login_datetime` varchar(30) NOT NULL,
  PRIMARY KEY  (`login_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table t_login_log
#


#
# Source for table t_post
#

CREATE TABLE `t_post` (
  `post_id` int(11) NOT NULL auto_increment COMMENT '帖子ID',
  `board_id` int(11) NOT NULL default '0' COMMENT '论坛ID',
  `topic_id` int(11) NOT NULL default '0' COMMENT '话题ID',
  `user_id` int(11) NOT NULL default '0' COMMENT '发表者ID',
  `post_type` tinyint(4) NOT NULL default '2' COMMENT '帖子类型 1:主帖子 2:回复帖子',
  `post_title` varchar(50) NOT NULL COMMENT '帖子标题',
  `post_text` text NOT NULL COMMENT '帖子内容',
  `create_time` date NOT NULL COMMENT '创建时间',
  PRIMARY KEY  (`post_id`),
  KEY `IDX_POST_TOPIC_ID` (`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='帖子';

#
# Dumping data for table t_post
#

INSERT INTO `t_post` VALUES (1,1,1,1,1,'SpringMVC','Spring Web MVC是一种基于Java的实现了Web MVC设计模式的请求驱动类型的轻量级Web框架\r\n','2016-03-07');
INSERT INTO `t_post` VALUES (2,1,2,1,1,'配置\r\详解','谁能告诉我SpringMVC的详细配置呢','2016-03-07');
INSERT INTO `t_post` VALUES (3,1,3,1,1,'test3','http://localhost/forum/boardManage.do?method=addTopicPage&boardId=1','2016-03-16');
INSERT INTO `t_post` VALUES (4,1,4,1,1,'test5','http://localhost/forum/boardManage.do?method=addTopicPage&boardId=1','2016-03-16');
INSERT INTO `t_post` VALUES (5,4,5,1,1,'AOP背后的故事','AOP背后的故事\r\n','2016-04-16');
INSERT INTO `t_post` VALUES (6,0,5,1,2,'铁杵磨成针','铁杵磨成针............\r\n','2016-04-16');
INSERT INTO `t_post` VALUES (7,4,6,1,1,'IOC的原理一','IOC的原理深入讲解\r\n','2016-04-16');
INSERT INTO `t_post` VALUES (8,4,7,1,1,'IOC的原理二','IOC的原理深入讲解','2016-04-16');
INSERT INTO `t_post` VALUES (14,5,14,1,1,'d','dddddddddddddd','2016-04-12');
INSERT INTO `t_post` VALUES (15,5,15,1,1,'dad','sdfffffffffffffffffff','2016-04-12');
INSERT INTO `t_post` VALUES (20,1,20,1,1,'测试。。。。','测试。。。。','2016-04-17');
INSERT INTO `t_post` VALUES (21,1,21,1,1,'测试。。。。','测试。。。。','2016-04-17');
INSERT INTO `t_post` VALUES (22,1,22,1,1,'SpringMVC集成','SpringMVC集成！！','2016-04-18');
INSERT INTO `t_post` VALUES (23,1,23,1,1,'SpringMVC集成','SpringMVC集成！！','2016-04-18');
INSERT INTO `t_post` VALUES (24,1,1,1,2,'SpringMVC集成','SpringMVC集成！！','2016-04-18');

#
# Source for table t_topic
#

CREATE TABLE `t_topic` (
  `topic_id` int(11) NOT NULL auto_increment COMMENT '帖子ID',
  `board_id` int(11) NOT NULL COMMENT '所属论坛',
  `topic_title` varchar(100) NOT NULL default '' COMMENT '帖子标题',
  `user_id` int(11) NOT NULL default '0' COMMENT '发表用户',
  `create_time` date NOT NULL COMMENT '发表时间',
  `last_post` date NOT NULL COMMENT '最后回复时间',
  `topic_views` int(11) NOT NULL default '1' COMMENT '浏览数',
  `topic_replies` int(11) NOT NULL default '0' COMMENT '回复数',
  `digest` int(11) NOT NULL COMMENT '0:不是精华话题 1:是精华话题',
  PRIMARY KEY  (`topic_id`),
  KEY `IDX_TOPIC_USER_ID` (`user_id`),
  KEY `IDX_TOPIC_TITLE` (`topic_title`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='话题';

#
# Dumping data for table t_topic
#

INSERT INTO `t_topic` VALUES (1,1,'test',1,'2016-03-07','2016-04-18',0,1,1);
INSERT INTO `t_topic` VALUES (2,1,'test2',1,'2016-03-07','2016-03-07',0,0,1);
INSERT INTO `t_topic` VALUES (3,1,'test3',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `t_topic` VALUES (4,1,'test5',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `t_topic` VALUES (5,4,'AOP背后的故事',1,'2016-03-16','2016-03-16',0,1,1);
INSERT INTO `t_topic` VALUES (6,4,'IOC的原理一',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `t_topic` VALUES (7,4,'IOC的原理二',1,'2016-03-16','2016-03-16',0,0,0);
INSERT INTO `t_topic` VALUES (14,5,'d',1,'2016-04-12','2016-04-12',0,0,0);
INSERT INTO `t_topic` VALUES (15,5,'dad',1,'2016-04-12','2016-04-12',0,0,0);
INSERT INTO `t_topic` VALUES (20,1,'测试。。。。',1,'2016-04-17','2016-04-17',0,0,0);
INSERT INTO `t_topic` VALUES (21,1,'测试。。。。',1,'2016-04-17','2016-04-17',0,0,0);
INSERT INTO `t_topic` VALUES (22,1,'SpringMVC集成',1,'2016-04-18','2016-04-18',0,0,0);
INSERT INTO `t_topic` VALUES (23,1,'SpringMVC集成',1,'2016-04-18','2016-04-18',0,0,0);

#
# Source for table t_user
#

CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL auto_increment COMMENT '用户Id',
  `user_name` varchar(30) NOT NULL COMMENT '用户名',
  `password` varchar(30) NOT NULL default '' COMMENT '密码',
  `user_type` tinyint(4) NOT NULL default '1' COMMENT '1:普通用户 2:管理员',
  `locked` tinyint(4) NOT NULL default '0' COMMENT '0:未锁定 1:锁定',
  `credit` int(11) default NULL COMMENT '积分',
  `last_visit` datetime default NULL COMMENT '最后登陆时间',
  `last_ip` varchar(20) default NULL COMMENT '最后登陆IP',
  PRIMARY KEY  (`user_id`),
  KEY `AK_AK_USER_USER_NAME` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Dumping data for table t_user
#

INSERT INTO `t_user` VALUES (1,'tom','1234',2,0,203,NULL,NULL);
INSERT INTO `t_user` VALUES (2,'john','1234',2,1,10,NULL,NULL);
INSERT INTO `t_user` VALUES (3,'ggg','123123',1,0,110,NULL,NULL);
