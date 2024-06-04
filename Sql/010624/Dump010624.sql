--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22
-- Dumped by pg_dump version 10.22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    idadmin integer NOT NULL,
    mail character varying(255) NOT NULL,
    pwd character varying(255) NOT NULL
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_idadmin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_idadmin_seq OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_idadmin_seq OWNED BY public.admin.idadmin;


--
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    idcategorie integer NOT NULL,
    nomcategorie character varying(255) NOT NULL
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- Name: categorie_idcategorie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorie_idcategorie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorie_idcategorie_seq OWNER TO postgres;

--
-- Name: categorie_idcategorie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorie_idcategorie_seq OWNED BY public.categorie.idcategorie;


--
-- Name: categoriecoureur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoriecoureur (
    idcoureur integer NOT NULL,
    idcategorie integer NOT NULL
);


ALTER TABLE public.categoriecoureur OWNER TO postgres;

--
-- Name: coureur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coureur (
    idcoureur integer NOT NULL,
    nomcoureur character varying(255) NOT NULL,
    numero integer NOT NULL,
    genre integer NOT NULL,
    datenaissance date NOT NULL,
    idequipe integer NOT NULL
);


ALTER TABLE public.coureur OWNER TO postgres;

--
-- Name: coureur_idcoureur_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coureur_idcoureur_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coureur_idcoureur_seq OWNER TO postgres;

--
-- Name: coureur_idcoureur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coureur_idcoureur_seq OWNED BY public.coureur.idcoureur;


--
-- Name: coureuretape; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coureuretape (
    idetape integer NOT NULL,
    idcoureur integer NOT NULL,
    dateheurearrivee timestamp without time zone
);


ALTER TABLE public.coureuretape OWNER TO postgres;

--
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    idcourse integer NOT NULL,
    nomcourse character varying(255) NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- Name: course_idcourse_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_idcourse_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.course_idcourse_seq OWNER TO postgres;

--
-- Name: course_idcourse_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_idcourse_seq OWNED BY public.course.idcourse;


--
-- Name: equipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipe (
    idequipe integer NOT NULL,
    nomequipe character varying(255) NOT NULL,
    mail character varying(255) NOT NULL,
    pwd character varying(255) NOT NULL
);


ALTER TABLE public.equipe OWNER TO postgres;

--
-- Name: equipe_idequipe_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.equipe_idequipe_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.equipe_idequipe_seq OWNER TO postgres;

--
-- Name: equipe_idequipe_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.equipe_idequipe_seq OWNED BY public.equipe.idequipe;


--
-- Name: etape; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.etape (
    idetape integer NOT NULL,
    nometape character varying(255) NOT NULL,
    longueur numeric(18,2) NOT NULL,
    nbrcoureurequipe integer NOT NULL,
    dateheuredepart timestamp without time zone NOT NULL,
    idcourse integer NOT NULL
);


ALTER TABLE public.etape OWNER TO postgres;

--
-- Name: etape_idetape_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.etape_idetape_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.etape_idetape_seq OWNER TO postgres;

--
-- Name: etape_idetape_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.etape_idetape_seq OWNED BY public.etape.idetape;


--
-- Name: pointrang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pointrang (
    idrang integer NOT NULL,
    classement integer NOT NULL,
    points integer NOT NULL
);


ALTER TABLE public.pointrang OWNER TO postgres;

--
-- Name: pointrang_idrang_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pointrang_idrang_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pointrang_idrang_seq OWNER TO postgres;

--
-- Name: pointrang_idrang_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pointrang_idrang_seq OWNED BY public.pointrang.idrang;


--
-- Name: v_coureuretapeclassement; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_coureuretapeclassement AS
 SELECT ce.idetape,
    e.nometape,
    eq.idequipe,
    eq.nomequipe,
    ce.idcoureur,
    c.nomcoureur,
    e.dateheuredepart,
    ce.dateheurearrivee,
    (ce.dateheurearrivee - e.dateheuredepart) AS diff,
    (date_part('epoch'::text, (ce.dateheurearrivee - e.dateheuredepart)) / (3600)::double precision) AS hour_diff,
    (date_part('epoch'::text, (ce.dateheurearrivee - e.dateheuredepart)) / (86400)::double precision) AS day_diff,
    row_number() OVER (PARTITION BY ce.idetape ORDER BY (ce.dateheurearrivee - e.dateheuredepart)) AS classement
   FROM (((public.coureuretape ce
     JOIN public.coureur c ON ((c.idcoureur = ce.idcoureur)))
     JOIN public.equipe eq ON ((eq.idequipe = c.idequipe)))
     JOIN public.etape e ON ((e.idetape = ce.idetape)))
  GROUP BY ce.idetape, e.nometape, eq.idequipe, eq.nomequipe, ce.idcoureur, c.nomcoureur, e.dateheuredepart, ce.dateheurearrivee
  ORDER BY ce.idetape, (ce.dateheurearrivee - e.dateheuredepart);


ALTER TABLE public.v_coureuretapeclassement OWNER TO postgres;

--
-- Name: v_coureurrang; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_coureurrang AS
 SELECT vc.idetape,
    vc.nometape,
    vc.idequipe,
    vc.nomequipe,
    vc.idcoureur,
    vc.nomcoureur,
    vc.dateheuredepart,
    vc.dateheurearrivee,
    vc.diff,
    vc.hour_diff,
    vc.day_diff,
    vc.classement,
        CASE
            WHEN (r.points IS NOT NULL) THEN r.points
            ELSE 0
        END AS points
   FROM (public.v_coureuretapeclassement vc
     LEFT JOIN public.pointrang r ON ((vc.classement = r.classement)))
  ORDER BY vc.idetape, vc.classement;


ALTER TABLE public.v_coureurrang OWNER TO postgres;

--
-- Name: v_classementindividuel; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementindividuel AS
 SELECT v_coureurrang.idcoureur,
    v_coureurrang.nomcoureur,
    c.numero,
    e.nomequipe,
    dense_rank() OVER (ORDER BY (sum(v_coureurrang.points)) DESC) AS rang,
    sum(v_coureurrang.points) AS points
   FROM ((public.v_coureurrang
     JOIN public.coureur c ON ((c.idcoureur = v_coureurrang.idcoureur)))
     JOIN public.equipe e ON ((e.idequipe = c.idequipe)))
  GROUP BY v_coureurrang.idcoureur, v_coureurrang.nomcoureur, c.numero, e.nomequipe;


ALTER TABLE public.v_classementindividuel OWNER TO postgres;

--
-- Name: v_classementequipe; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementequipe AS
 SELECT e.idequipe,
    e.nomequipe,
    sum(vci.points) AS points,
    dense_rank() OVER (ORDER BY (sum(vci.points)) DESC) AS rang
   FROM ((public.v_classementindividuel vci
     JOIN public.coureur c ON ((c.idcoureur = vci.idcoureur)))
     JOIN public.equipe e ON ((e.idequipe = c.idequipe)))
  GROUP BY e.idequipe, e.nomequipe;


ALTER TABLE public.v_classementequipe OWNER TO postgres;

--
-- Name: v_coureuretapenonarrivee; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_coureuretapenonarrivee AS
 SELECT ce.idetape,
    e.nometape,
    c.idcoureur,
    c.nomcoureur,
    c.numero
   FROM ((public.coureuretape ce
     JOIN public.coureur c ON ((c.idcoureur = ce.idcoureur)))
     JOIN public.etape e ON ((e.idetape = ce.idetape)))
  WHERE (ce.dateheurearrivee IS NULL);


ALTER TABLE public.v_coureuretapenonarrivee OWNER TO postgres;

--
-- Name: v_tempspassecoureuretape; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_tempspassecoureuretape AS
 SELECT ce.idetape,
    e.nometape,
    eq.idequipe,
    eq.nomequipe,
    ce.idcoureur,
    c.nomcoureur,
    e.dateheuredepart,
    ce.dateheurearrivee,
    (ce.dateheurearrivee - e.dateheuredepart) AS diff,
    (date_part('epoch'::text, (ce.dateheurearrivee - e.dateheuredepart)) / (3600)::double precision) AS hour_diff,
    (date_part('epoch'::text, (ce.dateheurearrivee - e.dateheuredepart)) / (86400)::double precision) AS day_diff
   FROM (((public.coureuretape ce
     JOIN public.coureur c ON ((c.idcoureur = ce.idcoureur)))
     JOIN public.equipe eq ON ((eq.idequipe = c.idequipe)))
     JOIN public.etape e ON ((e.idetape = ce.idetape)))
  GROUP BY ce.idetape, e.nometape, eq.idequipe, eq.nomequipe, ce.idcoureur, c.nomcoureur, e.dateheuredepart, ce.dateheurearrivee
  ORDER BY ce.idetape, (ce.dateheurearrivee - e.dateheuredepart);


ALTER TABLE public.v_tempspassecoureuretape OWNER TO postgres;

--
-- Name: admin idadmin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN idadmin SET DEFAULT nextval('public.admin_idadmin_seq'::regclass);


--
-- Name: categorie idcategorie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie ALTER COLUMN idcategorie SET DEFAULT nextval('public.categorie_idcategorie_seq'::regclass);


--
-- Name: coureur idcoureur; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureur ALTER COLUMN idcoureur SET DEFAULT nextval('public.coureur_idcoureur_seq'::regclass);


--
-- Name: course idcourse; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course ALTER COLUMN idcourse SET DEFAULT nextval('public.course_idcourse_seq'::regclass);


--
-- Name: equipe idequipe; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipe ALTER COLUMN idequipe SET DEFAULT nextval('public.equipe_idequipe_seq'::regclass);


--
-- Name: etape idetape; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etape ALTER COLUMN idetape SET DEFAULT nextval('public.etape_idetape_seq'::regclass);


--
-- Name: pointrang idrang; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pointrang ALTER COLUMN idrang SET DEFAULT nextval('public.pointrang_idrang_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (idadmin, mail, pwd) FROM stdin;
1	admin@gmail.com	admin
\.


--
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorie (idcategorie, nomcategorie) FROM stdin;
1	Homme
2	Femme
3	Junior
4	Senior
\.


--
-- Data for Name: categoriecoureur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoriecoureur (idcoureur, idcategorie) FROM stdin;
1	1
2	2
3	1
4	1
5	1
6	1
7	2
8	1
9	1
10	1
11	1
12	2
13	1
14	1
15	1
16	2
\.


--
-- Data for Name: coureur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coureur (idcoureur, nomcoureur, numero, genre, datenaissance, idequipe) FROM stdin;
1	Matio	10	1	1989-10-23	1
2	Maria	7	0	1990-01-18	1
3	Marka	18	1	1989-09-15	1
4	Paoly	5	1	1989-10-23	1
5	Lioka	3	1	1989-10-23	2
6	Matia	8	1	1990-01-18	2
7	Magdalena	12	0	1989-09-15	2
8	Josefa	9	1	1989-10-23	2
9	Jakoba	15	1	1989-10-23	3
10	Joda	2	1	1990-01-18	3
11	Benjamina	1	1	1989-09-15	3
12	Sarah	4	0	1989-10-23	3
13	Tomasy	11	1	1989-10-23	4
14	Petera	6	1	1990-01-18	4
15	Jodasy	20	1	1989-09-15	4
16	Rota	14	0	1989-10-23	4
\.


--
-- Data for Name: coureuretape; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coureuretape (idetape, idcoureur, dateheurearrivee) FROM stdin;
3	1	2024-06-02 14:37:00
4	1	2024-06-02 15:27:00
4	2	2024-06-02 15:28:00
4	4	2024-06-02 15:29:00
2	1	2024-06-02 16:25:00
2	3	2024-06-02 16:02:00
3	2	2024-06-02 17:03:00
3	4	2024-06-02 17:33:00
3	3	2024-06-02 17:45:00
3	5	2024-06-02 15:22:18
3	7	2024-06-02 16:39:58
3	10	2024-06-02 17:39:58
3	14	2024-06-02 17:42:25
3	16	2024-06-02 18:02:25
\.


--
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (idcourse, nomcourse) FROM stdin;
1	Trail RN4
\.


--
-- Data for Name: equipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipe (idequipe, nomequipe, mail, pwd) FROM stdin;
1	TrailXp	trailxp@gmail.com	trailxp
2	Kotrana Club	kotrana@gmail.com	kotrana
3	Lomay	lomay@gmail.com	lomay
4	Vikina	Vikina@gmail.com	vikina
\.


--
-- Data for Name: etape; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etape (idetape, nometape, longueur, nbrcoureurequipe, dateheuredepart, idcourse) FROM stdin;
1	Andohatapenaka-Ambohidratrimo	20.50	4	2024-06-01 08:00:00	1
2	Ambohidratrimo-Mahintsy	12.30	2	2024-06-01 13:00:00	1
3	Mahintsy-Ankazobe	30.80	4	2024-06-02 08:00:00	1
4	Ankazobe-Mahintsy	30.80	3	2024-06-01 14:00:00	1
\.


--
-- Data for Name: pointrang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pointrang (idrang, classement, points) FROM stdin;
1	1	10
2	2	6
3	3	4
4	4	2
5	5	1
\.


--
-- Name: admin_idadmin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_idadmin_seq', 1, true);


--
-- Name: categorie_idcategorie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorie_idcategorie_seq', 4, true);


--
-- Name: coureur_idcoureur_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coureur_idcoureur_seq', 16, true);


--
-- Name: course_idcourse_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_idcourse_seq', 1, true);


--
-- Name: equipe_idequipe_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipe_idequipe_seq', 4, true);


--
-- Name: etape_idetape_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etape_idetape_seq', 4, true);


--
-- Name: pointrang_idrang_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pointrang_idrang_seq', 5, true);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (idadmin);


--
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (idcategorie);


--
-- Name: categoriecoureur categoriecoureur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriecoureur
    ADD CONSTRAINT categoriecoureur_pkey PRIMARY KEY (idcoureur, idcategorie);


--
-- Name: coureur coureur_numero_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureur
    ADD CONSTRAINT coureur_numero_key UNIQUE (numero);


--
-- Name: coureur coureur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureur
    ADD CONSTRAINT coureur_pkey PRIMARY KEY (idcoureur);


--
-- Name: coureuretape coureuretape_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureuretape
    ADD CONSTRAINT coureuretape_pkey PRIMARY KEY (idetape, idcoureur);


--
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (idcourse);


--
-- Name: equipe equipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipe
    ADD CONSTRAINT equipe_pkey PRIMARY KEY (idequipe);


--
-- Name: etape etape_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_pkey PRIMARY KEY (idetape);


--
-- Name: pointrang pointrang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pointrang
    ADD CONSTRAINT pointrang_pkey PRIMARY KEY (idrang);


--
-- Name: categoriecoureur categoriecoureur_idcategorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriecoureur
    ADD CONSTRAINT categoriecoureur_idcategorie_fkey FOREIGN KEY (idcategorie) REFERENCES public.categorie(idcategorie);


--
-- Name: categoriecoureur categoriecoureur_idcoureur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoriecoureur
    ADD CONSTRAINT categoriecoureur_idcoureur_fkey FOREIGN KEY (idcoureur) REFERENCES public.coureur(idcoureur);


--
-- Name: coureur coureur_idequipe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureur
    ADD CONSTRAINT coureur_idequipe_fkey FOREIGN KEY (idequipe) REFERENCES public.equipe(idequipe);


--
-- Name: coureuretape coureuretape_idcoureur_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureuretape
    ADD CONSTRAINT coureuretape_idcoureur_fkey FOREIGN KEY (idcoureur) REFERENCES public.coureur(idcoureur);


--
-- Name: coureuretape coureuretape_idetape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coureuretape
    ADD CONSTRAINT coureuretape_idetape_fkey FOREIGN KEY (idetape) REFERENCES public.etape(idetape);


--
-- Name: etape etape_idcourse_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_idcourse_fkey FOREIGN KEY (idcourse) REFERENCES public.course(idcourse);


--
-- PostgreSQL database dump complete
--

