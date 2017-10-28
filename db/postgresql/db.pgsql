--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_role; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE api_role (
    role_id character varying(50) NOT NULL,
    role_name character varying(64)
);


ALTER TABLE api_role OWNER TO lqs;

--
-- Name: TABLE api_role; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE api_role IS 'api역할';


--
-- Name: COLUMN api_role.role_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_role.role_id IS '역할id';


--
-- Name: COLUMN api_role.role_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_role.role_name IS '역할명';


--
-- Name: api_user; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE api_user (
    user_id character varying(32) NOT NULL,
    user_name character varying(64),
    password character varying(128),
    cre_dt date,
    user_type character varying(1)
);


ALTER TABLE api_user OWNER TO lqs;

--
-- Name: TABLE api_user; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE api_user IS 'api접속유저';


--
-- Name: COLUMN api_user.user_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user.user_id IS 'seq';


--
-- Name: COLUMN api_user.user_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user.user_name IS '유저이름';


--
-- Name: COLUMN api_user.password; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user.password IS '패스워드';


--
-- Name: COLUMN api_user.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user.cre_dt IS '등록일';


--
-- Name: COLUMN api_user.user_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user.user_type IS '유저타입';


--
-- Name: api_user_role; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE api_user_role (
    user_id character varying(32) NOT NULL,
    role_id character varying(50) NOT NULL
);


ALTER TABLE api_user_role OWNER TO lqs;

--
-- Name: TABLE api_user_role; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE api_user_role IS 'api유저역할';


--
-- Name: COLUMN api_user_role.user_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user_role.user_id IS '유저id';


--
-- Name: COLUMN api_user_role.role_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN api_user_role.role_id IS '역할id';


--
-- Name: bbs_content; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE bbs_content (
    content_seq integer NOT NULL,
    bbs_uid character varying(36) NOT NULL,
    title character varying(255),
    content text,
    cre_dt timestamp without time zone,
    cre_usr character varying(32),
    mod_dt timestamp without time zone,
    mod_usr character varying(32)
);


ALTER TABLE bbs_content OWNER TO lqs;

--
-- Name: TABLE bbs_content; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE bbs_content IS '게시판내용';


--
-- Name: COLUMN bbs_content.content_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.content_seq IS '순번';


--
-- Name: COLUMN bbs_content.bbs_uid; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.bbs_uid IS '게시판uid';


--
-- Name: COLUMN bbs_content.title; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.title IS '제목';


--
-- Name: COLUMN bbs_content.content; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.content IS '내용';


--
-- Name: COLUMN bbs_content.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.cre_dt IS '생성일';


--
-- Name: COLUMN bbs_content.cre_usr; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.cre_usr IS '생성자';


--
-- Name: COLUMN bbs_content.mod_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.mod_dt IS '수정일';


--
-- Name: COLUMN bbs_content.mod_usr; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_content.mod_usr IS '수정자';


--
-- Name: bbs_file; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE bbs_file (
    file_seq integer NOT NULL,
    bbs_uid character varying(36) NOT NULL,
    file_name character varying(128),
    file_path character varying(256),
    file_url character varying(256),
    file_dir character varying(256),
    file_ext character varying(6),
    file_size bigint,
    content_seq integer NOT NULL
);


ALTER TABLE bbs_file OWNER TO lqs;

--
-- Name: COLUMN bbs_file.file_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_seq IS '파일seq';


--
-- Name: COLUMN bbs_file.bbs_uid; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.bbs_uid IS '게시판uid';


--
-- Name: COLUMN bbs_file.file_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_name IS '파일이름';


--
-- Name: COLUMN bbs_file.file_path; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_path IS '파일경로';


--
-- Name: COLUMN bbs_file.file_url; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_url IS '파일url';


--
-- Name: COLUMN bbs_file.file_dir; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_dir IS '파일디렉토리';


--
-- Name: COLUMN bbs_file.file_ext; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_ext IS '파일확장자';


--
-- Name: COLUMN bbs_file.file_size; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.file_size IS '파일사이즈';


--
-- Name: COLUMN bbs_file.content_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_file.content_seq IS '게시물seq';


--
-- Name: bbs_reply; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE bbs_reply (
    reply_seq integer NOT NULL,
    bbs_uid character varying(36) NOT NULL,
    content_seq integer NOT NULL,
    reply character varying(500),
    cre_usr character varying(32),
    cre_dt timestamp without time zone,
    mod_dt timestamp without time zone,
    parent_seq integer
);


ALTER TABLE bbs_reply OWNER TO lqs;

--
-- Name: TABLE bbs_reply; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE bbs_reply IS '게시판댓글';


--
-- Name: COLUMN bbs_reply.reply_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.reply_seq IS '댓글seq';


--
-- Name: COLUMN bbs_reply.bbs_uid; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.bbs_uid IS '게시판uid';


--
-- Name: COLUMN bbs_reply.content_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.content_seq IS '게시물seq';


--
-- Name: COLUMN bbs_reply.reply; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.reply IS '댓글';


--
-- Name: COLUMN bbs_reply.cre_usr; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.cre_usr IS '생성자';


--
-- Name: COLUMN bbs_reply.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.cre_dt IS '생성일';


--
-- Name: COLUMN bbs_reply.mod_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.mod_dt IS '수정일';


--
-- Name: COLUMN bbs_reply.parent_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN bbs_reply.parent_seq IS '상위seq';


--
-- Name: lqs_app_fcm; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_app_fcm (
    token character varying(255) NOT NULL,
    app_id integer,
    allow_alert integer DEFAULT 1
);


ALTER TABLE lqs_app_fcm OWNER TO lqs;

--
-- Name: TABLE lqs_app_fcm; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_app_fcm IS '앱푸시정보';


--
-- Name: COLUMN lqs_app_fcm.token; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_app_fcm.token IS '토큰';


--
-- Name: COLUMN lqs_app_fcm.app_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_app_fcm.app_id IS 'seq(앱id)';


--
-- Name: COLUMN lqs_app_fcm.allow_alert; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_app_fcm.allow_alert IS '알람허용여부';


--
-- Name: lqs_car_disf_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_car_disf_info (
    car_no character varying(10) NOT NULL,
    facility_seq integer NOT NULL,
    disf_dt timestamp without time zone NOT NULL,
    admit_dt timestamp without time zone NOT NULL,
    car_disf_seq integer NOT NULL
);


ALTER TABLE lqs_car_disf_info OWNER TO lqs;

--
-- Name: TABLE lqs_car_disf_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_car_disf_info IS '차량소독정보';


--
-- Name: COLUMN lqs_car_disf_info.car_no; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_disf_info.car_no IS '차량번호';


--
-- Name: COLUMN lqs_car_disf_info.facility_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_disf_info.facility_seq IS '소독시설(seq)';


--
-- Name: COLUMN lqs_car_disf_info.disf_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_disf_info.disf_dt IS '소독일시';


--
-- Name: COLUMN lqs_car_disf_info.admit_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_disf_info.admit_dt IS '출입허용시간';


--
-- Name: COLUMN lqs_car_disf_info.car_disf_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_disf_info.car_disf_seq IS '소독SEQ';


--
-- Name: lqs_car_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_car_info (
    car_no character varying(10) NOT NULL,
    owner character varying(64),
    type character varying(50),
    model character varying(50),
    maker character varying(50),
    since_year integer,
    fuel_type character varying(1),
    company character varying(50),
    biz_type character varying(50),
    description character varying(500),
    cre_usr character varying(50),
    cre_dt date
);


ALTER TABLE lqs_car_info OWNER TO lqs;

--
-- Name: TABLE lqs_car_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_car_info IS '차량정보';


--
-- Name: COLUMN lqs_car_info.car_no; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.car_no IS '차량번호';


--
-- Name: COLUMN lqs_car_info.owner; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.owner IS '차량소유주';


--
-- Name: COLUMN lqs_car_info.type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.type IS '차량구분';


--
-- Name: COLUMN lqs_car_info.model; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.model IS '모델';


--
-- Name: COLUMN lqs_car_info.maker; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.maker IS '제조사';


--
-- Name: COLUMN lqs_car_info.since_year; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.since_year IS '연식';


--
-- Name: COLUMN lqs_car_info.fuel_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.fuel_type IS '유종(G,D,L,E)';


--
-- Name: COLUMN lqs_car_info.company; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.company IS '법인명';


--
-- Name: COLUMN lqs_car_info.biz_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.biz_type IS '소유주유형';


--
-- Name: COLUMN lqs_car_info.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.description IS '설명';


--
-- Name: COLUMN lqs_car_info.cre_usr; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.cre_usr IS '등록자';


--
-- Name: COLUMN lqs_car_info.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_car_info.cre_dt IS '등록일';


--
-- Name: lqs_disease_warn_stage; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_disease_warn_stage (
    seq integer NOT NULL,
    disease_code character varying(50) NOT NULL,
    stage integer NOT NULL,
    cre_dt timestamp without time zone NOT NULL
);


ALTER TABLE lqs_disease_warn_stage OWNER TO lqs;

--
-- Name: TABLE lqs_disease_warn_stage; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_disease_warn_stage IS '질병위기경보단계';


--
-- Name: COLUMN lqs_disease_warn_stage.seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disease_warn_stage.seq IS 'seq';


--
-- Name: COLUMN lqs_disease_warn_stage.disease_code; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disease_warn_stage.disease_code IS '질병코드';


--
-- Name: COLUMN lqs_disease_warn_stage.stage; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disease_warn_stage.stage IS '1:관심,2:주의,3:경계,4:심각';


--
-- Name: COLUMN lqs_disease_warn_stage.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disease_warn_stage.cre_dt IS '등록일';


--
-- Name: lqs_disf_facility; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_disf_facility (
    facility_seq integer NOT NULL,
    facility_name character varying(64),
    phone character varying(16),
    address_seq integer,
    description character varying(500),
    cre_dt date
);


ALTER TABLE lqs_disf_facility OWNER TO lqs;

--
-- Name: TABLE lqs_disf_facility; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_disf_facility IS '소독시설정보';


--
-- Name: COLUMN lqs_disf_facility.facility_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disf_facility.facility_seq IS 'seq';


--
-- Name: COLUMN lqs_disf_facility.facility_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disf_facility.facility_name IS '시설명';


--
-- Name: COLUMN lqs_disf_facility.phone; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disf_facility.phone IS '연락처';


--
-- Name: COLUMN lqs_disf_facility.address_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disf_facility.address_seq IS '소재지';


--
-- Name: COLUMN lqs_disf_facility.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disf_facility.description IS '설명';


--
-- Name: COLUMN lqs_disf_facility.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_disf_facility.cre_dt IS '등록일';


--
-- Name: lqs_driver_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_driver_info (
    driver_seq integer NOT NULL,
    driver_name character varying(64),
    gender integer,
    age integer,
    phone character varying(16),
    company character varying(50),
    fingerprint bytea,
    cre_dt date
);


ALTER TABLE lqs_driver_info OWNER TO lqs;

--
-- Name: TABLE lqs_driver_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_driver_info IS '차량운전자정';


--
-- Name: COLUMN lqs_driver_info.driver_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.driver_seq IS '운전자seq';


--
-- Name: COLUMN lqs_driver_info.driver_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.driver_name IS '운전자명';


--
-- Name: COLUMN lqs_driver_info.gender; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.gender IS '성별';


--
-- Name: COLUMN lqs_driver_info.age; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.age IS '나이';


--
-- Name: COLUMN lqs_driver_info.phone; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.phone IS '연락처';


--
-- Name: COLUMN lqs_driver_info.company; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.company IS '소속';


--
-- Name: COLUMN lqs_driver_info.fingerprint; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.fingerprint IS '지문';


--
-- Name: COLUMN lqs_driver_info.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_driver_info.cre_dt IS '등록일';


--
-- Name: lqs_farm_access_vehicle; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_farm_access_vehicle (
    car_no character varying(10) NOT NULL,
    farm_seq integer NOT NULL,
    cap_dt timestamp without time zone,
    reject_reason character varying(500),
    in_dt timestamp without time zone,
    out_dt timestamp without time zone,
    driver_seq integer,
    visit_plan_dt date,
    seq integer NOT NULL,
    car_disf_seq integer
);


ALTER TABLE lqs_farm_access_vehicle OWNER TO lqs;

--
-- Name: TABLE lqs_farm_access_vehicle; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_farm_access_vehicle IS '농장입출입정보';


--
-- Name: COLUMN lqs_farm_access_vehicle.car_no; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.car_no IS '차량번호';


--
-- Name: COLUMN lqs_farm_access_vehicle.farm_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.farm_seq IS 'seq(앱id)';


--
-- Name: COLUMN lqs_farm_access_vehicle.cap_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.cap_dt IS '번호인식시간';


--
-- Name: COLUMN lqs_farm_access_vehicle.reject_reason; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.reject_reason IS '미출입사유';


--
-- Name: COLUMN lqs_farm_access_vehicle.in_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.in_dt IS '입차시간';


--
-- Name: COLUMN lqs_farm_access_vehicle.out_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.out_dt IS '출차시간';


--
-- Name: COLUMN lqs_farm_access_vehicle.driver_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.driver_seq IS '운전자SEQ';


--
-- Name: COLUMN lqs_farm_access_vehicle.visit_plan_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.visit_plan_dt IS '방문예정일';


--
-- Name: COLUMN lqs_farm_access_vehicle.seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.seq IS 'SEQ';


--
-- Name: COLUMN lqs_farm_access_vehicle.car_disf_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_access_vehicle.car_disf_seq IS '차량소독SEQ';


--
-- Name: lqs_farm_disease; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_farm_disease (
    farm_seq integer NOT NULL,
    disease_code character varying(50),
    diagnosis_agy character varying(50),
    occ_dt timestamp without time zone,
    ter_dt timestamp without time zone,
    seq integer NOT NULL
);


ALTER TABLE lqs_farm_disease OWNER TO lqs;

--
-- Name: TABLE lqs_farm_disease; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_farm_disease IS '농장질병정보';


--
-- Name: COLUMN lqs_farm_disease.farm_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_disease.farm_seq IS 'seq(앱id)';


--
-- Name: COLUMN lqs_farm_disease.disease_code; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_disease.disease_code IS '질병종류';


--
-- Name: COLUMN lqs_farm_disease.diagnosis_agy; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_disease.diagnosis_agy IS '진단기관';


--
-- Name: COLUMN lqs_farm_disease.occ_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_disease.occ_dt IS '발생일';


--
-- Name: COLUMN lqs_farm_disease.ter_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_disease.ter_dt IS '해제일';


--
-- Name: COLUMN lqs_farm_disease.seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_disease.seq IS 'SEQ';


--
-- Name: lqs_farm_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_farm_info (
    farm_seq integer NOT NULL,
    biz_type character varying(50),
    reg_number character varying(50),
    farm_name character varying(64),
    owner character varying(64),
    phone character varying(16),
    address_seq integer,
    description character varying(500),
    cre_dt date,
    run_yn smallint DEFAULT 1
);


ALTER TABLE lqs_farm_info OWNER TO lqs;

--
-- Name: TABLE lqs_farm_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_farm_info IS '농정보';


--
-- Name: COLUMN lqs_farm_info.farm_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.farm_seq IS 'seq(앱id-8자리)';


--
-- Name: COLUMN lqs_farm_info.biz_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.biz_type IS '기업유형';


--
-- Name: COLUMN lqs_farm_info.reg_number; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.reg_number IS '등록번호';


--
-- Name: COLUMN lqs_farm_info.farm_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.farm_name IS '농장명';


--
-- Name: COLUMN lqs_farm_info.owner; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.owner IS '농장주';


--
-- Name: COLUMN lqs_farm_info.phone; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.phone IS '연락처';


--
-- Name: COLUMN lqs_farm_info.address_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.address_seq IS '소재지';


--
-- Name: COLUMN lqs_farm_info.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.description IS '설명';


--
-- Name: COLUMN lqs_farm_info.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.cre_dt IS '등록일';


--
-- Name: COLUMN lqs_farm_info.run_yn; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_info.run_yn IS '운영여부';


--
-- Name: lqs_farm_livestock; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_farm_livestock (
    farm_seq integer NOT NULL,
    ls_type character varying(50) NOT NULL,
    ls_count integer
);


ALTER TABLE lqs_farm_livestock OWNER TO lqs;

--
-- Name: TABLE lqs_farm_livestock; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_farm_livestock IS '농가가축정보';


--
-- Name: COLUMN lqs_farm_livestock.farm_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_livestock.farm_seq IS '농장seq(id)';


--
-- Name: COLUMN lqs_farm_livestock.ls_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_livestock.ls_type IS '가축종류';


--
-- Name: COLUMN lqs_farm_livestock.ls_count; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_farm_livestock.ls_count IS '가축증가수';


--
-- Name: lqs_lpr_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_lpr_info (
    lpr_seq integer NOT NULL,
    model character varying(50),
    loc_type character varying(50),
    loc_seq integer,
    description character varying(500),
    cre_dt date
);


ALTER TABLE lqs_lpr_info OWNER TO lqs;

--
-- Name: TABLE lqs_lpr_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_lpr_info IS '번호인식기정보';


--
-- Name: COLUMN lqs_lpr_info.lpr_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_info.lpr_seq IS 'seq';


--
-- Name: COLUMN lqs_lpr_info.model; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_info.model IS '모델';


--
-- Name: COLUMN lqs_lpr_info.loc_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_info.loc_type IS '설치위치구분';


--
-- Name: COLUMN lqs_lpr_info.loc_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_info.loc_seq IS '설치위치(farm,facility)';


--
-- Name: COLUMN lqs_lpr_info.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_info.description IS '설명';


--
-- Name: COLUMN lqs_lpr_info.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_info.cre_dt IS '등록일';


--
-- Name: lqs_lpr_status; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_lpr_status (
    lpr_seq integer NOT NULL,
    is_alive integer DEFAULT 0,
    status_msg character varying(255),
    cre_dt timestamp without time zone NOT NULL
);


ALTER TABLE lqs_lpr_status OWNER TO lqs;

--
-- Name: TABLE lqs_lpr_status; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_lpr_status IS '번호인식기상태정보';


--
-- Name: COLUMN lqs_lpr_status.lpr_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_status.lpr_seq IS 'seq';


--
-- Name: COLUMN lqs_lpr_status.is_alive; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_status.is_alive IS '0:정상, 1:오류';


--
-- Name: COLUMN lqs_lpr_status.status_msg; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_status.status_msg IS '상태메시지';


--
-- Name: COLUMN lqs_lpr_status.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_lpr_status.cre_dt IS '등록일';


--
-- Name: lqs_meta_disease; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE lqs_meta_disease (
    disease_code character varying(50) NOT NULL,
    disease_name character varying(64)
);


ALTER TABLE lqs_meta_disease OWNER TO lqs;

--
-- Name: TABLE lqs_meta_disease; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE lqs_meta_disease IS '질병정보';


--
-- Name: COLUMN lqs_meta_disease.disease_code; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_meta_disease.disease_code IS '질병코드';


--
-- Name: COLUMN lqs_meta_disease.disease_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN lqs_meta_disease.disease_name IS '질병명';


--
-- Name: sq_bbs_file; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_bbs_file
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_bbs_file OWNER TO lqs;

--
-- Name: sq_bbs_reply; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_bbs_reply
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_bbs_reply OWNER TO lqs;

--
-- Name: sq_lqs_car_disf_info; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_car_disf_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_car_disf_info OWNER TO lqs;

--
-- Name: sq_lqs_disease_warn_stage; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_disease_warn_stage
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_disease_warn_stage OWNER TO lqs;

--
-- Name: sq_lqs_disf_facility; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_disf_facility
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_disf_facility OWNER TO lqs;

--
-- Name: sq_lqs_driver_info; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_driver_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_driver_info OWNER TO lqs;

--
-- Name: sq_lqs_farm_access_vehicle; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_farm_access_vehicle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_farm_access_vehicle OWNER TO lqs;

--
-- Name: sq_lqs_farm_disease; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_farm_disease
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_farm_disease OWNER TO lqs;

--
-- Name: sq_lqs_lpr_info; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_lqs_lpr_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_lqs_lpr_info OWNER TO lqs;

--
-- Name: sq_sys_address; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_sys_address
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_sys_address OWNER TO lqs;

--
-- Name: sq_sys_code_master; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_sys_code_master
    START WITH 100517
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_sys_code_master OWNER TO lqs;

--
-- Name: sq_sys_group; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_sys_group
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_sys_group OWNER TO lqs;

--
-- Name: sq_sys_login_his; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_sys_login_his
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_sys_login_his OWNER TO lqs;

--
-- Name: sq_sys_menu_info; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_sys_menu_info
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_sys_menu_info OWNER TO lqs;

--
-- Name: sq_sys_role; Type: SEQUENCE; Schema: public; Owner: lqs
--

CREATE SEQUENCE sq_sys_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sq_sys_role OWNER TO lqs;

--
-- Name: sys_address; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_address (
    address_seq integer NOT NULL,
    zonecode character varying(6),
    jibun_address character varying(255),
    road_address character varying(255),
    detail_address character varying(255),
    sido character varying(50),
    sigungu character varying(50),
    sigungu_code character varying(50),
    roadname_code character varying(50),
    roadname character varying(50),
    building_code character varying(50),
    building_name character varying(50),
    bcode character varying(50),
    bname character varying(50),
    bname1 character varying(50)
);


ALTER TABLE sys_address OWNER TO lqs;

--
-- Name: TABLE sys_address; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_address IS '시스템주소';


--
-- Name: COLUMN sys_address.address_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.address_seq IS 'seq(id)';


--
-- Name: COLUMN sys_address.zonecode; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.zonecode IS '새우편번호';


--
-- Name: COLUMN sys_address.jibun_address; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.jibun_address IS '지번주소';


--
-- Name: COLUMN sys_address.road_address; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.road_address IS '도로명주소';


--
-- Name: COLUMN sys_address.detail_address; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.detail_address IS '상세주소';


--
-- Name: COLUMN sys_address.sido; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.sido IS '도시';


--
-- Name: COLUMN sys_address.sigungu; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.sigungu IS '시군구';


--
-- Name: COLUMN sys_address.sigungu_code; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.sigungu_code IS '시군구코드';


--
-- Name: COLUMN sys_address.roadname_code; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.roadname_code IS '도로명코드';


--
-- Name: COLUMN sys_address.roadname; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.roadname IS '도로명';


--
-- Name: COLUMN sys_address.building_code; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.building_code IS '건물코드';


--
-- Name: COLUMN sys_address.building_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.building_name IS '건물명';


--
-- Name: COLUMN sys_address.bcode; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.bcode IS '동/리코드';


--
-- Name: COLUMN sys_address.bname; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.bname IS '동/리이름';


--
-- Name: COLUMN sys_address.bname1; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_address.bname1 IS '읍/면이름';


--
-- Name: sys_auth; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_auth (
    menu_seq integer NOT NULL,
    target_id character varying(36) NOT NULL,
    target_type character varying(32) NOT NULL,
    auth_c integer,
    auth_r integer,
    auth_u integer,
    auth_d integer,
    auth_p integer
);


ALTER TABLE sys_auth OWNER TO lqs;

--
-- Name: TABLE sys_auth; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_auth IS '시스템권한';


--
-- Name: COLUMN sys_auth.menu_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.menu_seq IS '시퀀스';


--
-- Name: COLUMN sys_auth.target_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.target_id IS '대상id';


--
-- Name: COLUMN sys_auth.target_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.target_type IS '대상타입';


--
-- Name: COLUMN sys_auth.auth_c; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.auth_c IS '생성';


--
-- Name: COLUMN sys_auth.auth_r; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.auth_r IS '조회';


--
-- Name: COLUMN sys_auth.auth_u; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.auth_u IS '수정';


--
-- Name: COLUMN sys_auth.auth_d; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.auth_d IS '삭제';


--
-- Name: COLUMN sys_auth.auth_p; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_auth.auth_p IS '출력';


--
-- Name: sys_bbs_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_bbs_info (
    bbs_uid character varying(36) NOT NULL,
    bbs_id character varying(64),
    bbs_name character varying(64),
    attached integer,
    description character varying(500),
    cre_dt timestamp without time zone
);


ALTER TABLE sys_bbs_info OWNER TO lqs;

--
-- Name: TABLE sys_bbs_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_bbs_info IS '시스템게시판관리';


--
-- Name: COLUMN sys_bbs_info.bbs_uid; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_bbs_info.bbs_uid IS '게시판uid';


--
-- Name: COLUMN sys_bbs_info.bbs_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_bbs_info.bbs_id IS '게시판id';


--
-- Name: COLUMN sys_bbs_info.bbs_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_bbs_info.bbs_name IS '게시판명';


--
-- Name: COLUMN sys_bbs_info.attached; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_bbs_info.attached IS '파일사용';


--
-- Name: COLUMN sys_bbs_info.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_bbs_info.description IS '설명';


--
-- Name: COLUMN sys_bbs_info.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_bbs_info.cre_dt IS '생성일';


--
-- Name: sys_code_master; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_code_master (
    cd character varying NOT NULL,
    catgr character varying(20) NOT NULL,
    cd_nm character varying(500) NOT NULL,
    cd_id character varying(500),
    sort_no integer DEFAULT 0,
    use_yn character(1),
    cre_usr character varying(500) NOT NULL,
    cre_dt date NOT NULL,
    mod_usr character varying(500) NOT NULL,
    mod_dt date NOT NULL,
    remark character varying(4000)
);


ALTER TABLE sys_code_master OWNER TO lqs;

--
-- Name: sys_config; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_config (
    cfg_group character varying(32) NOT NULL,
    cfg_id character varying(50) NOT NULL,
    cfg_name character varying(64),
    cfg_value character varying(500),
    use_yn integer,
    description character varying(500)
);


ALTER TABLE sys_config OWNER TO lqs;

--
-- Name: TABLE sys_config; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_config IS '시스템환경정보';


--
-- Name: COLUMN sys_config.cfg_group; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_config.cfg_group IS '카테고리';


--
-- Name: COLUMN sys_config.cfg_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_config.cfg_id IS '변수id';


--
-- Name: COLUMN sys_config.cfg_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_config.cfg_name IS '변수명';


--
-- Name: COLUMN sys_config.cfg_value; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_config.cfg_value IS '변수값';


--
-- Name: COLUMN sys_config.use_yn; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_config.use_yn IS '사용여부';


--
-- Name: COLUMN sys_config.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_config.description IS '설명';


--
-- Name: sys_group; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_group (
    group_id integer NOT NULL,
    group_name character varying(64)
);


ALTER TABLE sys_group OWNER TO lqs;

--
-- Name: TABLE sys_group; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_group IS '시스템그룹메타';


--
-- Name: COLUMN sys_group.group_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_group.group_id IS '그룹id';


--
-- Name: COLUMN sys_group.group_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_group.group_name IS '그룹명';


--
-- Name: sys_group_authorities; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_group_authorities (
    group_id integer NOT NULL,
    role_id character varying(50) NOT NULL
);


ALTER TABLE sys_group_authorities OWNER TO lqs;

--
-- Name: TABLE sys_group_authorities; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_group_authorities IS '시스템그룹권한';


--
-- Name: COLUMN sys_group_authorities.group_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_group_authorities.group_id IS '그룹id';


--
-- Name: COLUMN sys_group_authorities.role_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_group_authorities.role_id IS '권한';


--
-- Name: sys_group_user; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_group_user (
    group_id integer NOT NULL,
    user_id character varying(32) NOT NULL
);


ALTER TABLE sys_group_user OWNER TO lqs;

--
-- Name: TABLE sys_group_user; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_group_user IS '시스사용자그룹';


--
-- Name: COLUMN sys_group_user.group_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_group_user.group_id IS '그룹id';


--
-- Name: COLUMN sys_group_user.user_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_group_user.user_id IS '아이디';


--
-- Name: sys_login_his; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_login_his (
    access_dt timestamp without time zone NOT NULL,
    principle character varying(64) NOT NULL,
    log_type character varying,
    req_ip character varying(36),
    req_device character varying(64),
    seq integer NOT NULL
);


ALTER TABLE sys_login_his OWNER TO lqs;

--
-- Name: sys_menu_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_menu_info (
    menu_seq integer NOT NULL,
    menu_id character varying(64) NOT NULL,
    menu_name character varying(64) NOT NULL,
    menu_type character varying(50) NOT NULL,
    description character varying(500),
    menu_url character varying(255),
    menu_icon character varying(50),
    menu_order integer,
    use_yn smallint,
    parent_seq integer,
    bbs_uid character varying(36)
);


ALTER TABLE sys_menu_info OWNER TO lqs;

--
-- Name: TABLE sys_menu_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_menu_info IS '시스템메뉴';


--
-- Name: COLUMN sys_menu_info.menu_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_seq IS '시퀀스';


--
-- Name: COLUMN sys_menu_info.menu_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_id IS '메뉴id';


--
-- Name: COLUMN sys_menu_info.menu_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_name IS '메뉴명';


--
-- Name: COLUMN sys_menu_info.menu_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_type IS '메뉴타입';


--
-- Name: COLUMN sys_menu_info.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.description IS '설명';


--
-- Name: COLUMN sys_menu_info.menu_url; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_url IS 'url';


--
-- Name: COLUMN sys_menu_info.menu_icon; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_icon IS '아이콘';


--
-- Name: COLUMN sys_menu_info.menu_order; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.menu_order IS '정렬순서';


--
-- Name: COLUMN sys_menu_info.use_yn; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.use_yn IS '사용여부';


--
-- Name: COLUMN sys_menu_info.parent_seq; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.parent_seq IS '부모';


--
-- Name: COLUMN sys_menu_info.bbs_uid; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_menu_info.bbs_uid IS '게시판UID';


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_role (
    role_id character varying(50) NOT NULL,
    role_name character varying(64),
    description character varying(500),
    cre_dt date,
    mod_dt date,
    editabled integer,
    parent_id character varying(50)
);


ALTER TABLE sys_role OWNER TO lqs;

--
-- Name: TABLE sys_role; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_role IS '시스템역할메타';


--
-- Name: COLUMN sys_role.role_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.role_id IS '권한';


--
-- Name: COLUMN sys_role.role_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.role_name IS '역할명';


--
-- Name: COLUMN sys_role.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.description IS '설명';


--
-- Name: COLUMN sys_role.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.cre_dt IS '생성일';


--
-- Name: COLUMN sys_role.mod_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.mod_dt IS '수정일';


--
-- Name: COLUMN sys_role.editabled; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.editabled IS '시스템사용여부';


--
-- Name: COLUMN sys_role.parent_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role.parent_id IS '부모ID';


--
-- Name: sys_role_hierarchy; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_role_hierarchy (
    parent_role character varying(50) NOT NULL,
    child_role character varying(50) NOT NULL
);


ALTER TABLE sys_role_hierarchy OWNER TO lqs;

--
-- Name: TABLE sys_role_hierarchy; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_role_hierarchy IS '시스템역할구조';


--
-- Name: COLUMN sys_role_hierarchy.parent_role; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role_hierarchy.parent_role IS '부모';


--
-- Name: COLUMN sys_role_hierarchy.child_role; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_role_hierarchy.child_role IS '자식';


--
-- Name: sys_secured_res; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_secured_res (
    res_id character varying(50) NOT NULL,
    res_name character varying(64),
    res_pattern character varying(255) NOT NULL,
    description character varying(500),
    res_type character varying(50),
    sort_order integer,
    cre_dt date,
    mod_dt date
);


ALTER TABLE sys_secured_res OWNER TO lqs;

--
-- Name: TABLE sys_secured_res; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_secured_res IS '시스템보호리소스';


--
-- Name: COLUMN sys_secured_res.res_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.res_id IS '리소스id';


--
-- Name: COLUMN sys_secured_res.res_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.res_name IS '리소스명';


--
-- Name: COLUMN sys_secured_res.res_pattern; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.res_pattern IS '리소스url';


--
-- Name: COLUMN sys_secured_res.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.description IS '설명';


--
-- Name: COLUMN sys_secured_res.res_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.res_type IS 'value = url, method, pointcut';


--
-- Name: COLUMN sys_secured_res.sort_order; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.sort_order IS '정렬';


--
-- Name: COLUMN sys_secured_res.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.cre_dt IS '생성일';


--
-- Name: COLUMN sys_secured_res.mod_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res.mod_dt IS '수정일';


--
-- Name: sys_secured_res_role; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_secured_res_role (
    role_id character varying(50) NOT NULL,
    res_id character varying(50) NOT NULL
);


ALTER TABLE sys_secured_res_role OWNER TO lqs;

--
-- Name: TABLE sys_secured_res_role; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_secured_res_role IS '시스템보호리소스롤';


--
-- Name: COLUMN sys_secured_res_role.role_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res_role.role_id IS '권한';


--
-- Name: COLUMN sys_secured_res_role.res_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_secured_res_role.res_id IS '리소스ID';


--
-- Name: sys_signup; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_signup (
    user_id character varying(32) NOT NULL,
    user_name character varying(64) NOT NULL,
    password character varying(128) NOT NULL,
    phone character varying(11),
    birthday character(8),
    email character varying(64),
    cre_dt timestamp without time zone,
    approval character varying(1),
    confirm_uuid character varying(36) NOT NULL,
    confirm character varying(1)
);


ALTER TABLE sys_signup OWNER TO lqs;

--
-- Name: sys_user_authorities; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_user_authorities (
    user_id character varying(32) NOT NULL,
    role_id character varying(50) NOT NULL
);


ALTER TABLE sys_user_authorities OWNER TO lqs;

--
-- Name: TABLE sys_user_authorities; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_user_authorities IS '시스템유저권';


--
-- Name: COLUMN sys_user_authorities.user_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_authorities.user_id IS '아이디';


--
-- Name: COLUMN sys_user_authorities.role_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_authorities.role_id IS '권한';


--
-- Name: sys_user_info; Type: TABLE; Schema: public; Owner: lqs
--

CREATE TABLE sys_user_info (
    principle character varying(64) NOT NULL,
    user_id character varying(32) NOT NULL,
    password character varying(128) NOT NULL,
    user_name character varying(64),
    user_type character varying(32),
    phone character varying(16),
    email character varying(64),
    description character varying(1000),
    use_yn smallint,
    cre_dt timestamp without time zone,
    birthday character varying(8),
    cre_usr character varying(32)
);


ALTER TABLE sys_user_info OWNER TO lqs;

--
-- Name: TABLE sys_user_info; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON TABLE sys_user_info IS '시스템사용';


--
-- Name: COLUMN sys_user_info.principle; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.principle IS 'uid';


--
-- Name: COLUMN sys_user_info.user_id; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.user_id IS '아이디';


--
-- Name: COLUMN sys_user_info.password; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.password IS '패스워드';


--
-- Name: COLUMN sys_user_info.user_name; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.user_name IS '이름';


--
-- Name: COLUMN sys_user_info.user_type; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.user_type IS '사용자구분';


--
-- Name: COLUMN sys_user_info.phone; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.phone IS '연락처';


--
-- Name: COLUMN sys_user_info.email; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.email IS '이메일';


--
-- Name: COLUMN sys_user_info.description; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.description IS '설명';


--
-- Name: COLUMN sys_user_info.use_yn; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.use_yn IS '사용여부';


--
-- Name: COLUMN sys_user_info.cre_dt; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.cre_dt IS '등록일';


--
-- Name: COLUMN sys_user_info.birthday; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.birthday IS '생년월일';


--
-- Name: COLUMN sys_user_info.cre_usr; Type: COMMENT; Schema: public; Owner: lqs
--

COMMENT ON COLUMN sys_user_info.cre_usr IS '등록자';


--
-- Data for Name: api_role; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY api_role (role_id, role_name) FROM stdin;
ROLE_LPR	번호인식기서버
ROLE_KIOSK	키오스크
ROLE_FARM	농장
\.


--
-- Data for Name: api_user; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY api_user (user_id, user_name, password, cre_dt, user_type) FROM stdin;
20170002	Doll농장	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	2017-10-17	F
20170001	가온농장	a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3	2017-10-17	F
20170003	돌고래농장	3e0a3501a65b4a7bf889c6f180cc6e35747e5aaff931cc90b760671efa09aeac	2017-10-17	F
20170005	돌고래농장	3e0a3501a65b4a7bf889c6f180cc6e35747e5aaff931cc90b760671efa09aeac	2017-10-17	F
\.


--
-- Data for Name: api_user_role; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY api_user_role (user_id, role_id) FROM stdin;
20170002	ROLE_FARM
20170001	ROLE_FARM
20170003	ROLE_FARM
20170005	ROLE_FARM
\.


--
-- Data for Name: bbs_content; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY bbs_content (content_seq, bbs_uid, title, content, cre_dt, cre_usr, mod_dt, mod_usr) FROM stdin;
2	cb1d17f7-1abb-4f01-98b7-16feae8d4960	wefwef	wefwef	2017-08-22 17:32:27.671887	admin	2017-08-22 17:32:27.671887	admin
3	cb1d17f7-1abb-4f01-98b7-16feae8d4960	테스트	123	2017-09-07 19:59:15.595314	user1	2017-09-07 19:59:15.595314	user1
1	cb1d17f7-1abb-4f01-98b7-16feae8d4960	자유게시판 1	<p>bbs-content</p><p>게시판 내용</p><p><strong>굵게</strong></p><p><span style="text-decoration:underline;">밑줄</span></p><p><em>기울임"11"</em></p>	2017-08-22 09:43:08.96963	admin	2017-09-12 13:58:21.945934	admin
4	cb1d17f7-1abb-4f01-98b7-16feae8d4960	ㄹㄹ4ㄹ	ㄹㄹㄹㄹ	2017-09-12 14:12:19.278137	admin	2017-09-12 14:12:19.278137	admin
\.


--
-- Data for Name: bbs_file; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY bbs_file (file_seq, bbs_uid, file_name, file_path, file_url, file_dir, file_ext, file_size, content_seq) FROM stdin;
\.


--
-- Data for Name: bbs_reply; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY bbs_reply (reply_seq, bbs_uid, content_seq, reply, cre_usr, cre_dt, mod_dt, parent_seq) FROM stdin;
2	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	123	admin	2017-08-22 09:49:45.971432	2017-08-22 09:49:45.971432	\N
5	cb1d17f7-1abb-4f01-98b7-16feae8d4960	2	fff	admin	2017-08-22 17:32:50.581096	2017-08-22 17:32:50.581096	\N
6	cb1d17f7-1abb-4f01-98b7-16feae8d4960	3	ㅁㅁㅁ	admin	2017-09-07 19:59:21.871564	2017-09-07 19:59:21.871564	\N
7	cb1d17f7-1abb-4f01-98b7-16feae8d4960	3	ㄹㄷㄹㄷㄹ	user1	2017-09-07 19:59:30.057935	2017-09-07 19:59:30.057935	\N
8	cb1d17f7-1abb-4f01-98b7-16feae8d4960	3	ㄹㄹㄹㄹ	admin	2017-09-07 19:59:44.682271	2017-09-07 19:59:44.682271	\N
9	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㅁㅁㅁ	admin	2017-09-12 13:17:47.005092	2017-09-12 13:17:47.005092	\N
10	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	123123123	admin	2017-09-12 13:17:50.805511	2017-09-12 13:17:50.805511	\N
11	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㅅㅎ34ㅎ	admin	2017-09-12 13:18:37.320666	2017-09-12 13:18:37.320666	\N
12	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㅇ	admin	2017-09-12 13:41:30.459134	2017-09-12 13:41:30.459134	\N
13	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㄹ3ㄷ	admin	2017-09-12 13:41:32.31054	2017-09-12 13:41:32.31054	\N
14	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㄹㅈㄷㄹ	admin	2017-09-12 13:41:33.743295	2017-09-12 13:41:33.743295	\N
16	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㅈㄹㄷ	admin	2017-09-12 13:41:36.345315	2017-09-12 13:41:36.345315	\N
18	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	1ㄹ3	admin	2017-09-12 13:41:40.91101	2017-09-12 13:41:40.91101	\N
20	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㄹ23	admin	2017-09-12 13:41:44.109526	2017-09-12 13:41:44.109526	\N
21	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㄹ23ㄹ	admin	2017-09-12 13:41:45.527598	2017-09-12 13:41:45.527598	\N
23	cb1d17f7-1abb-4f01-98b7-16feae8d4960	1	ㄹ23	admin	2017-09-12 13:41:48.888889	2017-09-12 13:41:48.888889	\N
\.


--
-- Data for Name: lqs_app_fcm; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_app_fcm (token, app_id, allow_alert) FROM stdin;
123qwe1123	20170003	1
1231qwe1123	20170003	1
12313qw123	20170003	1
123qwe123	20170005	1
1231qw123	20170005	1
\.


--
-- Data for Name: lqs_car_disf_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_car_disf_info (car_no, facility_seq, disf_dt, admit_dt, car_disf_seq) FROM stdin;
30가3333	2	2017-09-22 17:00:38.709	2017-09-22 22:00:38.709	9
30가3333	2	2017-09-22 17:01:56.41	2017-09-22 22:01:56.41	99
30가3333	2	2017-09-22 17:02:54.275	2017-09-22 22:02:54.275	999
30가3333	2	2017-09-22 17:02:57.07	2017-09-22 22:02:57.07	9999
30가3333	2	2017-09-22 17:03:01.13	2017-09-22 22:03:01.13	999999
30가3333	2	2017-09-22 17:03:06.814	2017-09-22 22:03:06.814	9997
30가3333	2	2017-09-22 17:03:54.727	2017-09-22 22:03:54.727	8678678
30가3333	2	2017-09-22 17:07:23.122	2017-09-22 22:07:23.122	77867
30가3333	2	2017-09-22 17:08:13.599	2017-09-22 22:08:13.599	67867
12가3942	1	2017-09-21 12:22:22	2017-10-23 17:22:22	6786786
22가2222	1	2017-09-22 12:22:22	2017-10-23 15:28:52	678678
12가3942	1	2017-10-24 15:03:51.136	2017-10-24 20:03:51.136	786786
30가1234	1	2017-10-25 21:51:19.218	2017-10-26 02:51:19.218	3
30가1234	1	2017-10-25 11:51:19.218	2017-10-22 16:51:19	1
30가1234	1	2017-10-22 11:51:19	2017-10-23 16:51:19	2
30가1234	1	2017-10-25 21:51:19.218	2017-10-25 02:51:19	4
\.


--
-- Data for Name: lqs_car_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_car_info (car_no, owner, type, model, maker, since_year, fuel_type, company, biz_type, description, cre_usr, cre_dt) FROM stdin;
20가1293	김개똥	100531001	df2ef23f	현대	201701	G	\N	100520001	vdfververㄹㄹㄹㄹ	\N	2017-11-02
30어2304	이말자	100531001	a0303	르노삼성	201704	E		100520001	ffff		2017-09-21
12가3942	가온소프트	100531002	23-42-34-7	폭스바겐	201003	D		100520002	fff		2017-09-21
33가2334	우리농장	100531002	34904ㅅ3	폭스바겐	201003	D		100520002	fff		2017-09-21
55가2332	미등록차량	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: lqs_disease_warn_stage; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_disease_warn_stage (seq, disease_code, stage, cre_dt) FROM stdin;
99	1	1	2017-10-26 20:22:38
101	2	4	2017-10-27 05:03:01
98	2	3	2017-10-25 05:03:01
100	1	2	2017-10-27 10:22:11
\.


--
-- Data for Name: lqs_disf_facility; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_disf_facility (facility_seq, facility_name, phone, address_seq, description, cre_dt) FROM stdin;
1	하동A시설	055-1289-7391	15	123ㄱ23ㄱ	2017-09-20
2	헬리코박터살균시설A	055-3933-8282	16	비고비고삐공	2017-09-22
\.


--
-- Data for Name: lqs_driver_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_driver_info (driver_seq, driver_name, gender, age, phone, company, fingerprint, cre_dt) FROM stdin;
1001	개똥이당	\N	\N	\N	\N	\N	\N
3	소똥이당	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: lqs_farm_access_vehicle; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_farm_access_vehicle (car_no, farm_seq, cap_dt, reject_reason, in_dt, out_dt, driver_seq, visit_plan_dt, seq, car_disf_seq) FROM stdin;
30어2304	20170002	2017-10-18 11:45:33	\N	2017-10-19 11:45:35	\N	\N	\N	44	\N
30어2304	20170005	2017-10-18 11:45:33	\N	2017-10-18 11:45:35	\N	\N	\N	535	\N
12가3942	20170005	2017-10-19 11:45:33	\N	2017-10-19 11:45:35	\N	\N	\N	552345	\N
12가3942	20170005	2017-10-24 15:03:51.136	\N	2017-10-24 20:05:51.136	\N	\N	\N	2454	\N
20가1293	20170005	2017-10-19 11:40:33	\N	2017-10-19 11:40:35	\N	\N	\N	524524	\N
33가2334	1	\N	\N	\N	\N	3	2017-10-25	1	\N
33가2334	9	\N	\N	\N	\N	3	2017-10-25	3	\N
33가2334	20170002	\N	\N	\N	\N	3	2017-10-25	6	1
33가2334	20170005	2017-10-25 21:51:19.218	\N	\N	\N	3	2017-10-25	5	1
33가2334	20170005	2017-10-25 21:52:19	\N	\N	\N	\N	\N	8	\N
11가2334	20170005	2017-10-25 21:55:19	\N	2017-10-25 21:55:19.218	\N	\N	\N	9	\N
55가2332	20170005	2017-10-25 21:51:19.218	\N	2017-10-25 21:55:19.218	\N	\N	\N	10	\N
33가2334	20170005	\N	\N	\N	\N	3	2017-10-26	4	1
33가2334	20170005	\N	\N	\N	\N	3	2017-10-24	2	\N
\.


--
-- Data for Name: lqs_farm_disease; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_farm_disease (farm_seq, disease_code, diagnosis_agy, occ_dt, ter_dt, seq) FROM stdin;
20170005	2	\N	2017-10-25 19:11:31.362	\N	5
20170005	1	\N	2017-10-26 19:11:31.362	2017-10-27 19:11:31	3
20170005	2	\N	2017-10-25 19:11:31.362	2017-10-26 19:49:17.37	4
\.


--
-- Data for Name: lqs_farm_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_farm_info (farm_seq, biz_type, reg_number, farm_name, owner, phone, address_seq, description, cre_dt, run_yn) FROM stdin;
20170002	100520002	2838183838	Doll농장	돌아이	01038384747	6	농장설명	2017-09-15	1
20170001	100520001	28383438	가온농장	김가온	010-1111-1111	3	333	2017-09-15	1
20170005	100520002	1290393932	돌고래농장	돌핀	01083283834	16	비고입니다	2017-09-18	1
20170003	100520002	1290393932	돌고래농장	돌핀	01083283834	15	비고입니다	2017-09-18	1
\.


--
-- Data for Name: lqs_farm_livestock; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_farm_livestock (farm_seq, ls_type, ls_count) FROM stdin;
20170001	100523003	3
20170003	100523003	5
20170003	100523002	100000
\.


--
-- Data for Name: lqs_lpr_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_lpr_info (lpr_seq, model, loc_type, loc_seq, description, cre_dt) FROM stdin;
3	1111112-3-123-12-3-123	F	20170003	설명입니다.	2017-09-19
4	10923-234-23-423-4	L	1	거점A시설\n입니다.	2017-09-19
2	ee33333333333331-2-3-3-4-3	F	20170005	efwefwefwe34f23423ffff	2017-09-19
\.


--
-- Data for Name: lqs_lpr_status; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_lpr_status (lpr_seq, is_alive, status_msg, cre_dt) FROM stdin;
3	0	string	2017-10-20 10:31:02
2	0	disconnected	2017-10-19 11:45:33
2	1	\N	2017-10-19 11:45:35
2	1	\N	2017-10-20 10:30:02.949
2	1	\N	2017-10-20 10:35:02
\.


--
-- Data for Name: lqs_meta_disease; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY lqs_meta_disease (disease_code, disease_name) FROM stdin;
1	콜레라
2	AI
3	정신병
4	광우병
5	맥주병
\.


--
-- Name: sq_bbs_file; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_bbs_file', 1, false);


--
-- Name: sq_bbs_reply; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_bbs_reply', 26, true);


--
-- Name: sq_lqs_car_disf_info; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_car_disf_info', 4, true);


--
-- Name: sq_lqs_disease_warn_stage; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_disease_warn_stage', 1, false);


--
-- Name: sq_lqs_disf_facility; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_disf_facility', 2, true);


--
-- Name: sq_lqs_driver_info; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_driver_info', 1, false);


--
-- Name: sq_lqs_farm_access_vehicle; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_farm_access_vehicle', 10, true);


--
-- Name: sq_lqs_farm_disease; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_farm_disease', 5, true);


--
-- Name: sq_lqs_lpr_info; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_lqs_lpr_info', 4, true);


--
-- Name: sq_sys_address; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_sys_address', 17, true);


--
-- Name: sq_sys_code_master; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_sys_code_master', 100534, true);


--
-- Name: sq_sys_group; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_sys_group', 4, true);


--
-- Name: sq_sys_login_his; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_sys_login_his', 184, true);


--
-- Name: sq_sys_menu_info; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_sys_menu_info', 36, true);


--
-- Name: sq_sys_role; Type: SEQUENCE SET; Schema: public; Owner: lqs
--

SELECT pg_catalog.setval('sq_sys_role', 6, true);


--
-- Data for Name: sys_address; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_address (address_seq, zonecode, jibun_address, road_address, detail_address, sido, sigungu, sigungu_code, roadname_code, roadname, building_code, building_name, bcode, bname, bname1) FROM stdin;
3	13463	경기 성남시 분당구 운중동 895-1	경기 성남시 분당구 산운로68번길 7-7	33333	경기	성남시 분당구	41135	4340495	산운로68번길	4113511500108950001000001		4113511500	운중동	
6	25511	강원 강릉시 교동 1817-1	강원 강릉시 가작로 6	농장 123	강원	강릉시	42150	3220001	가작로	4215011000118170001000001		4215011000	교동	
14	34615		대전 동구 철갑2길 2	나래관	대전	동구	30110	4292509	철갑2길	3011011300102990034019072	대전전통나래관	3011011300	소제동	
15	52340	경남 하동군 고전면 고하리 226	경남 하동군 고전면 고하길 3	주소123	경남	하동군	48850	4832034	고하길	4885035026102260000043556		4885035026	고하리	고전면
16	52339	경남 하동군 고전면 신월리 780	경남 하동군 고전면 공설운동장로 366-20	234234	경남	하동군	48850	3344002	공설운동장로	4885035023107800000048145		4885035023	신월리	고전면
\.


--
-- Data for Name: sys_auth; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_auth (menu_seq, target_id, target_type, auth_c, auth_r, auth_u, auth_d, auth_p) FROM stdin;
27	ROLE_ADMIN	ROLE	1	1	1	1	0
16	ROLE_ADMIN	ROLE	1	1	1	1	0
15	ROLE_ADMIN	ROLE	1	1	1	1	0
11	ROLE_USER	ROLE	0	0	0	0	0
17	ROLE_ADMIN	ROLE	1	1	1	1	0
12	ROLE_USER	ROLE	0	0	0	0	0
22	ROLE_ADMIN	ROLE	1	1	1	1	0
18	ROLE_ADMIN	ROLE	1	1	1	1	0
24	ROLE_ADMIN	ROLE	0	1	0	1	1
14	ROLE_USER	ROLE	0	0	0	0	0
26	ROLE_ADMIN	ROLE	1	1	1	1	1
27	ROLE_USER	ROLE	0	0	0	0	0
16	ROLE_USER	ROLE	0	0	0	0	0
20	ROLE_ADMIN	ROLE	1	1	1	1	1
14	ROLE_ADMIN	ROLE	1	1	1	1	1
15	ROLE_USER	ROLE	0	0	0	0	0
17	ROLE_USER	ROLE	0	0	0	0	0
22	ROLE_USER	ROLE	0	0	0	0	0
18	ROLE_USER	ROLE	0	0	0	0	0
24	ROLE_USER	ROLE	0	1	0	0	0
26	ROLE_USER	ROLE	0	1	0	0	0
30	ROLE_ADMIN	ROLE	1	1	1	1	1
29	ROLE_ADMIN	ROLE	1	1	1	1	1
11	ROLE_ADMIN	ROLE	1	1	1	1	1
12	ROLE_ADMIN	ROLE	1	1	1	1	1
35	ROLE_ADMIN	ROLE	1	1	1	1	1
36	ROLE_ADMIN	ROLE	0	1	0	0	0
21	ROLE_ADMIN	ROLE	1	1	1	1	1
28	ROLE_ADMIN	ROLE	1	1	1	1	1
20	ROLE_USER	ROLE	0	1	0	0	0
21	ROLE_USER	ROLE	0	1	0	0	0
28	ROLE_USER	ROLE	0	1	0	0	0
\.


--
-- Data for Name: sys_bbs_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_bbs_info (bbs_uid, bbs_id, bbs_name, attached, description, cre_dt) FROM stdin;
b1648cc1-0c31-4ae2-886a-88bb398295f5	file	자료게시판	1	자료게시판입니다.	2017-08-18 17:17:51.248983
cb1d17f7-1abb-4f01-98b7-16feae8d4960	free	자유게시판	0	자유게시판입니다.	2017-08-18 17:17:41.097016
aa2d14d7-2gdf-5h01-55c7-55faef8f4498	test	테스트게시판	0	테스트게시판입니다.	2017-08-18 17:17:41.097016
\.


--
-- Data for Name: sys_code_master; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_code_master (cd, catgr, cd_nm, cd_id, sort_no, use_yn, cre_usr, cre_dt, mod_usr, mod_dt, remark) FROM stdin;
100000	0	기준코드	1	1	1	admin	2016-11-08	admin	2016-11-08	\N
100019	100017	슈퍼관리자	5000000000	1	1	devqed	2016-11-08	devqed	2017-07-04	\N
100017	100000	사용자구분	_USER_TYPE_	1	1	devqed	2016-11-08	devqed	2016-11-08	\N
100026	100000	성별구분	_SEX_	1	1	devqed	2016-11-08	devqed	2016-11-08	\N
100031	100026	남성	M	1	1	devqed	2016-11-08	devqed	2016-11-08	\N
100030	100026	여성	F	1	1	devqed	2016-11-08	devqed	2016-11-08	\N
100400	100017	학생	5114000000	3	1	devqed	2017-01-13	devqed	2017-07-04	\N
100501	100500	진행중	500001	1	1	wsbaek	2016-11-10	wsbaek	2017-07-05	\N
100502	100500	마감	500090	1	1	wsbaek	2016-11-10	wsbaek	2017-07-05	\N
100385	100500	대기	500050	1	1	wsbaek	2016-11-29	wsbaek	2016-11-29	\N
100500	100000	진행상태	_STATUS_	1	1	wsbaek	2016-11-10	wsbaek	2016-11-10	\N
100468	100000	메뉴구분	_MENU_TYPE_	1	1	admin	2017-08-17	admin	2017-08-17	메뉴타입
100470	100468	게시판	100468002	2	1	admin	2017-08-17	admin	2017-08-17	게시판 페이지
100472	100000	아이콘	_ICON_	1	1	admin	2017-08-17	admin	2017-08-17	메뉴 아이콘(span class 적용)
100473	100472	canlendar	fa fa-calendar	1	1	admin	2017-08-17	admin	2017-08-17	달력
100474	100472	email	fa fa-envelope-o	1	1	admin	2017-08-17	admin	2017-08-17	이메일
100476	100472	book	glyphicon glyphicon-book	1	1	admin	2017-08-18	admin	2017-08-18	책
100477	100472	home	glyphicon glyphicon-home	1	1	admin	2017-08-18	admin	2017-08-18	집
100478	100472	checkbox	glyphicon glyphicon-check	1	1	admin	2017-08-18	admin	2017-08-18	체크박스
100479	100472	diamond	fa fa-diamond	1	1	admin	2017-08-18	admin	2017-08-18	다이아몬드
100480	100472	papper	glyphicon glyphicon-duplicate	1	1	admin	2017-08-18	admin	2017-08-18	문서
100481	100472	storage	glyphicon glyphicon-hdd	1	1	admin	2017-08-18	admin	2017-08-18	저장소(하드)
100482	100472	shopping cart	glyphicon glyphicon-shopping-cart	1	1	admin	2017-08-18	admin	2017-08-18	쇼핑카트
100483	100472	bell	glyphicon glyphicon-bell	1	1	admin	2017-08-18	admin	2017-08-18	종
100484	100472	desktop	fa fa-desktop	1	1	admin	2017-08-18	admin	2017-08-18	모니터
100485	100472	gear	fa fa-gears	1	1	admin	2017-08-18	admin	2017-08-18	기어
100486	100472	chart	fa fa-area-chart	1	1	admin	2017-08-18	admin	2017-08-18	차트
100487	100472	table	fa fa-table	1	1	admin	2017-08-18	admin	2017-08-18	테이블
100488	100472	global	glyphicon glyphicon-globe	1	1	admin	2017-08-18	admin	2017-08-18	지구본
100489	100472	circle	fa fa-dot-circle-o	1	1	admin	2017-08-18	admin	2017-08-18	원
100490	100472	clipboard	fa fa-clipboard	1	1	admin	2017-08-23	admin	2017-08-23	클립보드
100491	100472	popup	glyphicon glyphicon-modal-window	1	1	admin	2017-08-23	admin	2017-08-23	팝업윈도우
100492	100472	equalizer	glyphicon glyphicon-equalizer	1	1	admin	2017-08-23	admin	2017-08-23	이퀄라이저
100493	100472	fire	glyphicon glyphicon-fire	1	1	admin	2017-08-23	admin	2017-08-23	불
100494	100472	cube	fa fa-cube	1	1	admin	2017-08-23	admin	2017-08-23	큐브
100496	100472	tag	glyphicon glyphicon-tags	1	1	admin	2017-08-23	admin	2017-08-23	태그
100497	100472	grid	fa fa-th-large	1	1	admin	2017-08-23	admin	2017-08-23	그리드
100498	100472	spinner	fa fa-spinner	1	1	admin	2017-08-23	admin	2017-08-23	스피너
100499	100472	warning	fa fa-warning	1	1	admin	2017-08-23	admin	2017-08-23	경고
100500	100472	money	fa fa-money	1	1	admin	2017-08-23	admin	2017-08-23	돈
100502	100472	tag	glyphicon glyphicon-tags	1	1	admin	2017-08-23	admin	2017-08-23	태그
100503	100472	hand_r	fa fa-hand-o-right	1	1	admin	2017-08-23	admin	2017-08-23	오른손
100504	100472	bar	fa fa-bars	1	1	admin	2017-08-23	admin	2017-08-23	바
100511	100472	archive	fa fa-archive	1	1	admin	2017-08-23	admin	2017-08-23	아카이브
100512	100472	user	fa fa-user	1	1	admin	2017-08-24	admin	2017-08-24	유저
100501	100472	group	fa fa-group	1	1	admin	2017-08-23	admin	2017-08-24	그룹
100513	100472	clipboard	fa fa-clipboard	1	1	admin	2017-08-24	admin	2017-08-24	클립보드
100514	100472	list	fa fa-list-ul	1	1	admin	2017-08-24	admin	2017-08-24	리스트
100515	100472	sitemap	fa fa-sitemap	1	1	admin	2017-08-24	admin	2017-08-24	사이트맵
100516	100472	qrcode	fa fa-qrcode	1	1	admin	2017-08-24	admin	2017-08-24	QR코드
100519	100472	dashboard	fa fa-dashboard	1	1	admin	2017-08-29	admin	2017-08-29	대시보드
100466	100017	관리자	5100000000	2	1	admin	2017-07-04	admin	2017-08-30	
100520	100000	사업구분	_BIZ_TYPE_	1	1	admin	2017-09-15	admin	2017-09-15	개인, 법인 등...
100521	100520	법인	100520002	2	1	admin	2017-09-15	admin	2017-09-15	\N
100522	100520	개인	100520001	1	1	admin	2017-09-15	admin	2017-09-15	\N
100523	100000	가축종류	_LIVESTOCK_TYPE_	1	1	admin	2017-09-15	admin	2017-09-15	가축이 세분화 되면 다음에 따로 테이블을 만들던지 해야함
100524	100523	돼지	100523001	1	1	admin	2017-09-15	admin	2017-09-15	\N
100525	100523	닭	100523002	1	1	admin	2017-09-15	admin	2017-09-15	\N
100526	100523	소	100523003	1	1	admin	2017-09-15	admin	2017-09-15	\N
100469	100468	내부페이지	100468001	1	1	admin	2017-08-17	admin	2017-08-17	사용자 제작 페이지(내부링크)
100528	100472	car	fa fa-car	1	1	admin	2017-09-18	admin	2017-09-18	자동차
100529	100472	camera	fa fa-camera	1	1	admin	2017-09-19	admin	2017-09-19	카메라
100531	100000	차량구분	_CAR_TYPE_	1	1	admin	2017-09-21	admin	2017-09-21	차량종류
100533	100531	방역차량	100531002	1	1	admin	2017-09-21	admin	2017-09-21	\N
100534	100531	일반차량	100531001	1	1	admin	2017-09-21	admin	2017-09-21	\N
\.


--
-- Data for Name: sys_config; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_config (cfg_group, cfg_id, cfg_name, cfg_value, use_yn, description) FROM stdin;
SYSTEM	LOGO	로고	/resource/images/logo/logo.png	1	메인 로고이미지
SYSTEM	TITLE	타이틀	축산방역시스템	1	하동축산방역시스템
SYSTEM	APP_ADM_TEL	앱관리자연락처	055-112-0119	1	앱관리자연락처
LQS	DISF_ADMIT_TIME	소독허용시간	300	1	소독허용시간(min)
\.


--
-- Data for Name: sys_group; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_group (group_id, group_name) FROM stdin;
1	관리자
2	그룹1
3	모든유저그룹
4	fefefef
\.


--
-- Data for Name: sys_group_authorities; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_group_authorities (group_id, role_id) FROM stdin;
1	ROLE_ADMIN
\.


--
-- Data for Name: sys_group_user; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_group_user (group_id, user_id) FROM stdin;
1	admin
2	user1
3	user1
3	admin
\.


--
-- Data for Name: sys_login_his; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_login_his (access_dt, principle, log_type, req_ip, req_device, seq) FROM stdin;
2017-08-29 15:00:54.934451	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	10
2017-08-29 15:27:06.890683	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	11
2017-08-29 15:45:08.851842	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	12
2017-08-29 15:51:11.259345	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	13
2017-08-29 15:55:33.570829	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	14
2017-08-29 15:57:58.453886	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	15
2017-08-29 16:15:24.358599	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	16
2017-08-29 16:22:53.028238	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	17
2017-08-29 16:23:19.193804	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	18
2017-08-29 16:46:16.262198	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	19
2017-08-29 17:23:24.81867	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	20
2017-08-29 19:25:26.926022	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	21
2017-08-30 14:10:22.028379	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	22
2017-08-30 14:42:05.051341	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	23
2017-08-30 15:39:53.533628	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	24
2017-08-30 16:00:58.239965	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	25
2017-08-30 17:06:25.956041	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	26
2017-08-30 18:02:32.819456	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	27
2017-08-31 10:01:39.630659	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	28
2017-08-31 13:26:03.255999	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	29
2017-08-31 14:38:04.942381	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	30
2017-08-31 16:20:47.582723	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	31
2017-09-01 11:06:53.049815	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	32
2017-09-01 14:16:25.411227	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	33
2017-09-01 14:34:51.046688	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	34
2017-09-01 15:38:28.41502	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	35
2017-09-01 17:38:08.400792	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	36
2017-09-04 10:44:08.614829	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	37
2017-09-04 11:56:49.262474	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	38
2017-09-04 12:01:42.657275	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	39
2017-09-04 13:04:12.165946	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	40
2017-09-04 13:15:58.017431	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	41
2017-09-04 14:10:12.781879	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	42
2017-09-04 15:23:52.552582	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	43
2017-09-04 15:29:20.794544	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	44
2017-09-04 15:38:06.833996	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	45
2017-09-04 17:24:05.959083	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	46
2017-09-04 17:59:15.108693	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	47
2017-09-04 18:01:36.00387	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	48
2017-09-04 18:03:20.480887	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	49
2017-09-04 18:04:34.274963	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	50
2017-09-04 18:17:00.130272	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	51
2017-09-04 18:35:38.69578	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	52
2017-09-04 18:37:45.88532	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	53
2017-09-05 10:48:07.791139	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	54
2017-09-05 11:04:11.396573	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	55
2017-09-05 11:32:02.554881	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	56
2017-09-05 12:11:18.385158	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	57
2017-09-05 15:26:17.949675	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	58
2017-09-05 15:28:25.346866	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	59
2017-09-05 16:08:28.224227	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	60
2017-09-05 16:26:27.807796	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	61
2017-09-05 16:30:24.243288	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	62
2017-09-05 16:32:04.964635	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	63
2017-09-05 17:35:04.572298	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	64
2017-09-05 18:17:58.906977	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	65
2017-09-05 19:08:47.34634	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	66
2017-09-05 19:13:20.836406	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	67
2017-09-05 19:26:13.689215	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	68
2017-09-05 19:26:27.831058	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	69
2017-09-05 19:32:07.194058	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	70
2017-09-07 19:58:17.879117	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	71
2017-09-07 19:58:52.600645	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	72
2017-09-07 20:01:19.88977	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	73
2017-09-07 20:07:32.580315	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	74
2017-09-07 20:09:56.316131	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	75
2017-09-07 20:49:46.096149	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	76
2017-09-07 20:52:24.455058	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	77
2017-09-07 20:55:18.188133	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	78
2017-09-07 21:03:42.735724	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	79
2017-09-07 21:06:51.208217	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	80
2017-09-07 21:06:54.667212	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	81
2017-09-08 11:39:50.869246	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	82
2017-09-08 11:49:11.891213	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	83
2017-09-08 11:49:25.007166	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	84
2017-09-08 11:59:58.512364	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	85
2017-09-08 13:32:47.12542	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	86
2017-09-08 13:34:48.661421	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	87
2017-09-08 14:21:30.440021	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	88
2017-09-08 16:17:22.432273	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	89
2017-09-08 16:29:42.618761	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	90
2017-09-08 16:53:46.797801	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	91
2017-09-08 16:59:28.536393	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	92
2017-09-08 17:05:11.717929	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	93
2017-09-08 17:13:42.375424	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	94
2017-09-08 17:28:44.686037	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	95
2017-09-08 17:31:17.762317	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	96
2017-09-08 17:38:03.739454	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	97
2017-09-08 17:40:52.622681	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	98
2017-09-08 17:43:54.622499	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	99
2017-09-08 17:59:07.652242	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	100
2017-09-08 18:10:39.616517	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	101
2017-09-08 18:12:34.953672	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	102
2017-09-11 11:08:47.531038	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	103
2017-09-11 11:32:47.547329	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	104
2017-09-11 11:57:15.594137	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	105
2017-09-11 13:49:15.351254	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	106
2017-09-11 14:39:13.231442	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	107
2017-09-11 14:44:15.942102	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	108
2017-09-11 15:12:19.419935	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	109
2017-09-11 17:09:43.158268	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	110
2017-09-12 10:52:40.673088	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	111
2017-09-12 11:47:52.153265	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	112
2017-09-12 12:05:33.009735	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	113
2017-09-12 13:09:25.019627	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	114
2017-09-12 13:17:35.390935	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	115
2017-09-12 14:53:24.594804	86577d38-4895-4f4b-95e6-b404491ed304	I	0:0:0:0:0:0:0:1	unknown	116
2017-09-12 14:54:14.239118	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	117
2017-09-12 16:59:01.33147	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	118
2017-09-12 17:05:45.283254	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	119
2017-09-12 19:07:15.320019	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	120
2017-09-12 20:03:01.160634	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	121
2017-09-13 19:55:34.401666	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	122
2017-09-14 13:07:43.134901	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	123
2017-09-14 13:39:41.27189	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	124
2017-09-14 13:55:46.209846	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	125
2017-09-14 16:31:53.968688	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	126
2017-09-14 16:38:11.509235	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	127
2017-09-14 16:49:11.880714	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	128
2017-09-14 17:03:50.201525	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	129
2017-09-14 17:04:42.991365	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	130
2017-09-14 17:24:18.765727	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	131
2017-09-14 18:51:03.495118	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	132
2017-09-15 10:51:11.548005	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	133
2017-09-15 10:52:22.325974	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	134
2017-09-15 10:54:43.65115	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	135
2017-09-15 13:44:06.2505	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	136
2017-09-15 14:05:30.48152	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	137
2017-09-15 14:53:25.531451	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	138
2017-09-15 14:57:16.574154	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	139
2017-09-15 15:27:54.476419	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	140
2017-09-15 15:48:09.0546	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	141
2017-09-15 15:57:34.803834	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	142
2017-09-15 16:19:08.949295	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	143
2017-09-15 18:14:15.440137	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	144
2017-09-18 11:12:13.831021	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	145
2017-09-18 13:27:58.554925	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	146
2017-09-18 15:17:43.89636	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	147
2017-09-18 15:46:06.291898	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	148
2017-09-18 16:54:21.948573	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	149
2017-09-18 17:01:29.799038	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	150
2017-09-18 18:01:35.913055	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	151
2017-09-18 18:32:31.182063	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	152
2017-09-19 13:30:27.805637	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	153
2017-09-19 14:04:14.033566	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	154
2017-09-19 14:30:45.21776	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	155
2017-09-19 16:25:02.956344	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	156
2017-09-19 16:57:48.570876	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	157
2017-09-19 20:12:40.736092	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	158
2017-09-20 15:05:05.943594	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	159
2017-09-20 16:03:20.955207	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	160
2017-09-20 16:12:43.412053	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	161
2017-09-20 17:26:30.934607	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	162
2017-09-20 18:08:55.119905	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	163
2017-09-21 10:53:31.073108	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	164
2017-09-21 11:14:55.535092	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	165
2017-09-21 11:18:39.929244	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	166
2017-09-21 11:18:40.186449	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	167
2017-09-21 13:12:57.181362	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	168
2017-09-21 13:19:25.432309	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	169
2017-09-21 13:23:45.195101	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	170
2017-09-21 14:46:19.559752	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	171
2017-09-21 14:50:17.335084	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	172
2017-09-21 14:52:49.317204	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	173
2017-09-21 15:00:29.370219	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	174
2017-09-21 15:36:06.392086	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	175
2017-09-21 17:35:16.300963	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	176
2017-09-21 17:48:59.891521	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	177
2017-09-22 09:42:00.505266	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	178
2017-09-22 11:28:46.063252	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	179
2017-09-22 16:59:35.218176	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	180
2017-09-22 18:14:29.1297	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	181
2017-10-18 11:17:22.844323	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	182
2017-10-20 11:02:33.323786	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	183
2017-10-20 11:22:36.10133	7086ebb9-bc78-4a80-b7a1-b54509970d4f	I	0:0:0:0:0:0:0:1	unknown	184
\.


--
-- Data for Name: sys_menu_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_menu_info (menu_seq, menu_id, menu_name, menu_type, description, menu_url, menu_icon, menu_order, use_yn, parent_seq, bbs_uid) FROM stdin;
1	system	시스템관리	100468001	관리자페이지	#	fa fa-gears	99999	1	0	\N
14	systemAuth	권한관리	100468001	시스템 권한을 관리합니다.	/sm/auth.do	fa fa-warning	30	1	1	
20	bbsFree	자유게시판	100468002	자유게시판입니다.	/bbs/board.do?bbs=cb1d17f7-1abb-4f01-98b7-16feae8d4960	fa fa-desktop	1	1	19	cb1d17f7-1abb-4f01-98b7-16feae8d4960
27	systemResource	권한리소스관리	100468001	시스템 리소스를 관리합니다.	/sm/auth/resource.do	fa fa-sitemap	35	1	1	
16	systemMenu	메뉴관리	100468001	메뉴를 관리합니다.	/sm/menu.do	fa fa-list-ul	45	1	1	
15	systemCode	공통코드관리	100468001	시스템에서 사용하는 코드를 관리합니다.	/sm/code.do	fa fa-qrcode	50	1	1	
21	bbsFile	자료게시판	100468002	자료게시판입니다.	/bbs/board.do?bbs=b1648cc1-0c31-4ae2-886a-88bb398295f5	fa fa-desktop	2	1	19	b1648cc1-0c31-4ae2-886a-88bb398295f5
28	farm	농가정보	100468001	농가정보를 관리합니다.	/farm.do	glyphicon glyphicon-home	1	1	25	
25	mgrFarm	농가관리	100468001	\N	#	glyphicon glyphicon-home	20	1	0	
19	bbs	게시판	100468001	게시판	#	glyphicon glyphicon-duplicate	10	1	0	
11	systemUser	사용자관리	100468001	사용자를 관리합니다.	/sm/user.do	fa fa-user	10	1	1	
12	systemGroupUser	사용자그룹관리	100468001	사용자 그룹을 관리합니다.	/sm/groupuser.do	fa fa-group	20	1	1	
17	systemBBS	게시판관리	100468001	게시판을 관리합니다.	/sm/bbs.do	fa fa-clipboard	60	1	1	
22	systemConfig	환경설정	100468001	시스템(프로젝트) 환경설정	/sm/config.do	fa fa-gears	70	1	1	
18	systemHisLogin	접속이력관리	100468001	로그인 이력을 관리합니다.	/sm/history/login.do	fa fa-desktop	1000	1	1	
26	mgrCar	차량관리	100468001	\N	\N	fa fa-car	30	1	0	
29	car	차량정보	100468001	모든 차량의 정보를 관리합니다.	/car.do	fa fa-car	1	1	26	
34	mgrFacility	시설관리	100468001	\N		glyphicon glyphicon-modal-window	50	1	0	
35	facility	소독시설정보	100468001	거점 소독시설 정보를 관리합니다.	/facility.do	glyphicon glyphicon-fire	1	1	34	
24	dashboard	대시보드	100468001	대시보드	/dashboard.do	fa fa-dashboard	1	1	0	
30	lpr	번호인식기정보	100468001	번호인식기 정보 관리	/lpr.do	fa fa-camera	5	1	34	
36	carDisf	차량소독정보	100468001	소독한 차량의 정보를 조회합니다.	/car/disf.do	glyphicon glyphicon-fire	20	1	26	
\.


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_role (role_id, role_name, description, cre_dt, mod_dt, editabled, parent_id) FROM stdin;
ROLE_ANONYMOUS	모든사용자	모든사용자	2017-08-10	2017-08-10	0	\N
IS_AUTHENTICATED_ANONYMOUSLY	익명사용자	익명사용자	2017-08-10	2017-08-10	0	ROLE_ANONYMOUS
ROLE_ADMIN	관리자	관리자	2017-08-10	2017-08-10	0	ROLE_USER
ROLE_USER	일반사용자	일반사용자	2017-08-10	2017-08-10	0	ROLE_ANONYMOUS
IS_AUTHENTICATED_REMEMBERED	REMEMBERED 사용자	REMEMBERED 사용자	2017-08-10	2017-08-10	0	ROLE_ANONYMOUS
ROLE_RESTRICTED	제한된사용자	제한된사용자	2017-08-10	2017-08-10	0	ROLE_ANONYMOUS
IS_AUTHENTICATED_FULLY	인증된사용자	인증된사용자	2017-08-10	2017-08-10	0	ROLE_ANONYMOUS
4	테스트 사용자	테스트용사용자12	2017-08-31	2017-09-01	1	ROLE_RESTRICTED
\.


--
-- Data for Name: sys_role_hierarchy; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_role_hierarchy (parent_role, child_role) FROM stdin;
ROLE_ANONYMOUS	ROLE_USER
ROLE_ANONYMOUS	IS_AUTHENTICATED_ANONYMOUSLY
ROLE_ANONYMOUS	ROLE_RESTRICTED
ROLE_ANONYMOUS	IS_AUTHENTICATED_FULLY
ROLE_ANONYMOUS	IS_AUTHENTICATED_REMEMBERED
ROLE_USER	ROLE_ADMIN
\.


--
-- Data for Name: sys_secured_res; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_secured_res (res_id, res_name, res_pattern, description, res_type, sort_order, cre_dt, mod_dt) FROM stdin;
web-000004	회원가입	/signup.do	회원가입 페이지	url	9000	2017-08-10	2017-08-10
web-000013	리소스	/resource/**	리소스	url	999900	2017-08-10	2017-08-10
web-000014	appinf	/appinf/**	앱정보	url	999901	2017-08-10	2017-08-10
web-000015	루트	/**	루트	url	999999	2017-08-10	2017-08-10
web-000031	자유게시판	/bbs/board.do?uid=cb1d17f7-1abb-4f01-98b7-16feae8d4960	자유게시판입니다.	url	1	2017-08-21	2017-08-21
web-000032	자료게시판	/bbs/board.do?uid=b1648cc1-0c31-4ae2-886a-88bb398295f5	자료게시판입니다.	url	2	2017-08-21	2017-08-21
web-000035	Dashboard	/dashboard.do	대시보드	url	1	2017-08-29	2017-08-29
web-000037	차량관리	#	\N	url	20	2017-08-29	2017-08-29
web-000005	회원가입	/signup/**	회원가입	url	9999	2017-08-10	2017-08-10
web-000009	권한관리	/sm/auth.do	시스템권한관리 페이지	url	1200	2017-08-10	2017-08-10
web-000038	권한리소스관리	/sm/auth/resource.do	권한 리소스를 관리합니다.	url	1700	2017-08-30	2017-08-30
web-000033	환경설정	/sm/config.do	시스템(프로젝트) 환경설정	url	1800	2017-08-28	2017-08-28
web-000001	로그인	/com/login/login.do	로그인 페이지	url	1	2017-08-10	2017-08-10
web-000003	사용자관리	/sm/user.do	시스템사용자관리 페이지	url	1000	2017-08-10	2017-08-10
web-000008	사용자그룹관리	/sm/usergroup.do	시스템사용자그룹관리 페이지	url	1100	2017-08-10	2017-08-10
web-000007	메뉴관리	/sm/menu.do	메뉴관리 페이지	url	1300	2017-08-10	2017-08-10
web-000010	공통코드관리	/sm/code.do	시스템공통코드관리 페이지	url	1400	2017-08-10	2017-08-10
web-000011	게시판관리	/sm/bbs.do	시스템게시판관리 페이지	url	1500	2017-08-10	2017-08-10
web-000012	접속이력관리	/sm/history/login.do	시스템접속이력관리 페이지	url	3000	2017-08-10	2017-08-10
web-000002	시스템메소드	/sm/**	시스템메소드	url	9999	2017-08-10	2017-08-10
web-000006	에러	/error/**	모든 에러 페이지	url	9001	2017-08-10	2017-08-10
web-000020	공통	/common/**	로그인유저 공통사용	url	999000	2017-08-10	2017-08-10
web-000040	차량정보	/car.do	모든 차량의 정보를 관리합니다.	url	1	2017-09-18	2017-09-18
web-000041	번호인식기	/lpr.do	번호인식기 정보 관리	url	5	2017-09-19	2017-09-19
web-000042	시설관리		\N	url	50	2017-09-20	2017-09-20
web-000043	소독시설정보	/facility.do	거점 소독시설 정보를 관리합니다.	url	1	2017-09-20	2017-09-20
web-000039	농가관리	/farm.do	농가정보를 관리합니다.	url	100	2017-09-04	2017-09-20
web-000044	차량소독정보	/car/disf.do	소독한 차량의 정보를 조회합니다.	url	20	2017-09-22	2017-09-22
\.


--
-- Data for Name: sys_secured_res_role; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_secured_res_role (role_id, res_id) FROM stdin;
ROLE_ANONYMOUS	web-000001
ROLE_USER	web-000001
ROLE_USER	web-000002
ROLE_ADMIN	web-000003
ROLE_ANONYMOUS	web-000004
ROLE_ANONYMOUS	web-000005
ROLE_ADMIN	web-000007
ROLE_ADMIN	web-000008
ROLE_ADMIN	web-000009
ROLE_ADMIN	web-000010
ROLE_ADMIN	web-000011
ROLE_ADMIN	web-000012
ROLE_ANONYMOUS	web-000013
ROLE_USER	web-000013
ROLE_ANONYMOUS	web-000014
ROLE_USER	web-000014
ROLE_USER	web-000015
ROLE_ADMIN	web-000038
ROLE_ADMIN	web-000033
ROLE_USER	web-000031
ROLE_USER	web-000032
ROLE_USER	web-000035
ROLE_USER	web-000039
ROLE_ANONYMOUS	web-000006
ROLE_USER	web-000006
ROLE_USER	web-000020
\.


--
-- Data for Name: sys_signup; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_signup (user_id, user_name, password, phone, birthday, email, cre_dt, approval, confirm_uuid, confirm) FROM stdin;
aaaa	이름	123	129381923	\N	warluck@naver.com	2017-07-14 10:17:05.743087	0	ba92cb22-aeda-4c60-994f-9269180b4da6	1
\.


--
-- Data for Name: sys_user_authorities; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_user_authorities (user_id, role_id) FROM stdin;
admin	ROLE_ADMIN
user1	ROLE_USER
admin	ROLE_USER
\.


--
-- Data for Name: sys_user_info; Type: TABLE DATA; Schema: public; Owner: lqs
--

COPY sys_user_info (principle, user_id, password, user_name, user_type, phone, email, description, use_yn, cre_dt, birthday, cre_usr) FROM stdin;
86577d38-4895-4f4b-95e6-b404491ed304	user1	3e0a3501a65b4a7bf889c6f180cc6e35747e5aaff931cc90b760671efa09aeac	유저1	5114000000	01011112222	user1@gaonsoft.com	user1 유저1	1	2017-06-09 00:00:00	20171101	admin
7086ebb9-bc78-4a80-b7a1-b54509970d4f	admin	3e0a3501a65b4a7bf889c6f180cc6e35747e5aaff931cc90b760671efa09aeac	관리자	5000000000	01012345678	admin@gaonsoft.com	슈퍼관리자 야호호호홍~a	1	2017-06-08 00:00:00	20021012	adimn
\.


--
-- Name: api_role api_role_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY api_role
    ADD CONSTRAINT api_role_pk PRIMARY KEY (role_id);


--
-- Name: api_user api_user_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY api_user
    ADD CONSTRAINT api_user_pk PRIMARY KEY (user_id);


--
-- Name: api_user_role api_user_role_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY api_user_role
    ADD CONSTRAINT api_user_role_pk PRIMARY KEY (user_id, role_id);


--
-- Name: bbs_content bbs_content_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY bbs_content
    ADD CONSTRAINT bbs_content_pk PRIMARY KEY (content_seq, bbs_uid);


--
-- Name: bbs_reply bbs_reply_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY bbs_reply
    ADD CONSTRAINT bbs_reply_pk PRIMARY KEY (reply_seq);


--
-- Name: lqs_app_fcm lqs_app_fcm_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_app_fcm
    ADD CONSTRAINT lqs_app_fcm_pk PRIMARY KEY (token);


--
-- Name: lqs_car_disf_info lqs_car_disf_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_car_disf_info
    ADD CONSTRAINT lqs_car_disf_info_pk PRIMARY KEY (car_disf_seq);


--
-- Name: lqs_car_info lqs_car_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_car_info
    ADD CONSTRAINT lqs_car_info_pk PRIMARY KEY (car_no);


--
-- Name: lqs_disease_warn_stage lqs_disease_warn_stage_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_disease_warn_stage
    ADD CONSTRAINT lqs_disease_warn_stage_pk PRIMARY KEY (seq);


--
-- Name: lqs_driver_info lqs_driver_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_driver_info
    ADD CONSTRAINT lqs_driver_info_pk PRIMARY KEY (driver_seq);


--
-- Name: lqs_farm_access_vehicle lqs_farm_access_vehicle_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_farm_access_vehicle
    ADD CONSTRAINT lqs_farm_access_vehicle_pk PRIMARY KEY (seq);


--
-- Name: lqs_farm_disease lqs_farm_disease_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_farm_disease
    ADD CONSTRAINT lqs_farm_disease_pk PRIMARY KEY (seq);


--
-- Name: lqs_farm_info lqs_farm_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_farm_info
    ADD CONSTRAINT lqs_farm_info_pk PRIMARY KEY (farm_seq);


--
-- Name: lqs_farm_livestock lqs_farm_livestock_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_farm_livestock
    ADD CONSTRAINT lqs_farm_livestock_pk PRIMARY KEY (farm_seq, ls_type);


--
-- Name: lqs_lpr_info lqs_lpr_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_lpr_info
    ADD CONSTRAINT lqs_lpr_info_pk PRIMARY KEY (lpr_seq);


--
-- Name: lqs_lpr_status lqs_lpr_status_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_lpr_status
    ADD CONSTRAINT lqs_lpr_status_pk PRIMARY KEY (lpr_seq, cre_dt);


--
-- Name: lqs_meta_disease lqs_meta_disease_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY lqs_meta_disease
    ADD CONSTRAINT lqs_meta_disease_pk PRIMARY KEY (disease_code);


--
-- Name: sys_code_master pk_tb_code_master; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_code_master
    ADD CONSTRAINT pk_tb_code_master PRIMARY KEY (cd, catgr);


--
-- Name: sys_address sys_address_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_address
    ADD CONSTRAINT sys_address_pk PRIMARY KEY (address_seq);


--
-- Name: sys_auth sys_auth_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_auth
    ADD CONSTRAINT sys_auth_pk PRIMARY KEY (menu_seq, target_id, target_type);


--
-- Name: sys_bbs_info sys_bbs_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_bbs_info
    ADD CONSTRAINT sys_bbs_info_pk PRIMARY KEY (bbs_uid);


--
-- Name: sys_config sys_config_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_config
    ADD CONSTRAINT sys_config_pk PRIMARY KEY (cfg_group, cfg_id);


--
-- Name: sys_group_authorities sys_group_authorities_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_group_authorities
    ADD CONSTRAINT sys_group_authorities_pk PRIMARY KEY (group_id, role_id);


--
-- Name: sys_menu_info sys_menu_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_menu_info
    ADD CONSTRAINT sys_menu_info_pk PRIMARY KEY (menu_seq, menu_id);


--
-- Name: sys_role_hierarchy sys_role_hierarchy_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_role_hierarchy
    ADD CONSTRAINT sys_role_hierarchy_pk PRIMARY KEY (parent_role, child_role);


--
-- Name: sys_role sys_role_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_role
    ADD CONSTRAINT sys_role_pk PRIMARY KEY (role_id);


--
-- Name: sys_secured_res sys_secured_res_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_secured_res
    ADD CONSTRAINT sys_secured_res_pk PRIMARY KEY (res_id);


--
-- Name: sys_secured_res_role sys_secured_res_role_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_secured_res_role
    ADD CONSTRAINT sys_secured_res_role_pk PRIMARY KEY (res_id, role_id);


--
-- Name: sys_user_authorities sys_user_authorities_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_user_authorities
    ADD CONSTRAINT sys_user_authorities_pk PRIMARY KEY (user_id, role_id);


--
-- Name: sys_group_user sys_user_group_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_group_user
    ADD CONSTRAINT sys_user_group_pk PRIMARY KEY (group_id, user_id);


--
-- Name: sys_user_info sys_user_info_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_user_info
    ADD CONSTRAINT sys_user_info_pk PRIMARY KEY (user_id);


--
-- Name: sys_login_his tb_login_history_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_login_his
    ADD CONSTRAINT tb_login_history_pk PRIMARY KEY (seq);


--
-- Name: sys_signup tb_signup_user_pk; Type: CONSTRAINT; Schema: public; Owner: lqs
--

ALTER TABLE ONLY sys_signup
    ADD CONSTRAINT tb_signup_user_pk PRIMARY KEY (confirm_uuid);


--
-- Name: pk_sys_menu_info; Type: INDEX; Schema: public; Owner: lqs
--

CREATE UNIQUE INDEX pk_sys_menu_info ON sys_menu_info USING btree (menu_seq);


--
-- Name: pk_sys_role; Type: INDEX; Schema: public; Owner: lqs
--

CREATE UNIQUE INDEX pk_sys_role ON sys_role USING btree (role_id);


--
-- PostgreSQL database dump complete
--

