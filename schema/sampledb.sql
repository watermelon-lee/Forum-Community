DROP DATABASE IF EXISTS sampledb;
CREATE DATABASE sampledb DEFAULT CHARACTER SET utf8;
USE sampledb;


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

