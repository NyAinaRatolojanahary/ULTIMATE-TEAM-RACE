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


--
-- Name: insert_categorie_coureur(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_categorie_coureur() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    coureur RECORD;
    id_homme INTEGER;
    id_femme INTEGER;
    id_junior INTEGER;
BEGIN
    -- R‚cup‚rer les IDs des cat‚gories
    SELECT idCategorie INTO id_homme FROM Categorie WHERE NomCategorie = 'Homme';
    SELECT idCategorie INTO id_femme FROM Categorie WHERE NomCategorie = 'Femme';
    SELECT idCategorie INTO id_junior FROM Categorie WHERE NomCategorie = 'Junior';

    -- Boucle sur tous les coureurs
    FOR coureur IN SELECT idCoureur, Genre, DateNaissance FROM Coureur LOOP
        -- Ins‚rer dans CategorieCoureur pour la cat‚gorie "Homme" ou "Femme"
        IF coureur.Genre = 'M' THEN
            INSERT INTO CategorieCoureur (idCoureur, idCategorie)
            VALUES (coureur.idCoureur, id_homme)
            ON CONFLICT (idCoureur, idCategorie) DO NOTHING;
        ELSIF coureur.Genre = 'F' THEN
            INSERT INTO CategorieCoureur (idCoureur, idCategorie)
            VALUES (coureur.idCoureur, id_femme)
            ON CONFLICT (idCoureur, idCategorie) DO NOTHING;
        END IF;

        -- Ins‚rer dans CategorieCoureur pour la cat‚gorie "Junior"
        IF age(coureur.DateNaissance) < INTERVAL '18 years' THEN
            INSERT INTO CategorieCoureur (idCoureur, idCategorie)
            VALUES (coureur.idCoureur, id_junior)
            ON CONFLICT (idCoureur, idCategorie) DO NOTHING;
        END IF;
    END LOOP;
END;
$$;


ALTER FUNCTION public.insert_categorie_coureur() OWNER TO postgres;

--
-- Name: reset(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.reset() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE 
    table_name text;
BEGIN
    FOR table_name IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname= 'public'
        AND tablename <> 'admin'
    LOOP
        EXECUTE format('DELETE FROM %I',table_name);
    END LOOP;
END;
$$;


ALTER FUNCTION public.reset() OWNER TO postgres;

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
    datenaissance date NOT NULL,
    idequipe integer NOT NULL,
    genre character(1)
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
    rang integer
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
-- Name: penaliteequipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.penaliteequipe (
    idetape integer NOT NULL,
    idequipe integer NOT NULL,
    tempspenalite time without time zone NOT NULL
);


ALTER TABLE public.penaliteequipe OWNER TO postgres;

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
-- Name: v_classementcategorie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementcategorie AS
 SELECT c.idcoureur,
    c.nomcoureur,
    cat.idcategorie,
    cat.nomcategorie,
    sum(pr.points) AS totalpoints,
    dense_rank() OVER (PARTITION BY cat.idcategorie ORDER BY (sum(pr.points)) DESC) AS classementfinal
   FROM (((( SELECT ce.idetape,
            cc.idcategorie,
            ce.idcoureur,
            date_part('epoch'::text, (ce.dateheurearrivee - min(ce.dateheurearrivee) OVER (PARTITION BY ce.idetape, cc.idcategorie))) AS difftemps,
            dense_rank() OVER (PARTITION BY ce.idetape, cc.idcategorie ORDER BY ce.dateheurearrivee) AS classement
           FROM (public.coureuretape ce
             JOIN public.categoriecoureur cc ON ((ce.idcoureur = cc.idcoureur)))) dtc
     JOIN public.pointrang pr ON ((dtc.classement = pr.classement)))
     JOIN public.coureur c ON ((dtc.idcoureur = c.idcoureur)))
     JOIN public.categorie cat ON ((dtc.idcategorie = cat.idcategorie)))
  GROUP BY c.idcoureur, c.nomcoureur, cat.nomcategorie, cat.idcategorie;


ALTER TABLE public.v_classementcategorie OWNER TO postgres;

--
-- Name: v_coureuretapeclassementpenalite; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_coureuretapeclassementpenalite AS
 SELECT ce.idetape,
    e.nometape,
    eq.idequipe,
    eq.nomequipe,
    ce.idcoureur,
    c.nomcoureur,
    e.dateheuredepart,
    ce.dateheurearrivee,
    COALESCE(pe.tempspenalite, '00:00:00'::time without time zone) AS penalite,
    ((ce.dateheurearrivee - e.dateheuredepart) + COALESCE(pe.tempspenalite, '00:00:00'::time without time zone)) AS diff,
    (date_part('epoch'::text, ((ce.dateheurearrivee - e.dateheuredepart) + COALESCE(pe.tempspenalite, '00:00:00'::time without time zone))) / (3600)::double precision) AS hour_diff,
    (date_part('epoch'::text, ((ce.dateheurearrivee - e.dateheuredepart) + COALESCE(pe.tempspenalite, '00:00:00'::time without time zone))) / (86400)::double precision) AS day_diff,
    dense_rank() OVER (PARTITION BY ce.idetape ORDER BY ((ce.dateheurearrivee - e.dateheuredepart) + COALESCE(pe.tempspenalite, '00:00:00'::time without time zone))) AS classement
   FROM ((((public.coureuretape ce
     JOIN public.coureur c ON ((c.idcoureur = ce.idcoureur)))
     JOIN public.equipe eq ON ((eq.idequipe = c.idequipe)))
     JOIN public.etape e ON ((e.idetape = ce.idetape)))
     LEFT JOIN public.penaliteequipe pe ON (((pe.idequipe = eq.idequipe) AND (pe.idetape = e.idetape))))
  GROUP BY ce.idetape, e.nometape, eq.idequipe, eq.nomequipe, ce.idcoureur, c.nomcoureur, e.dateheuredepart, ce.dateheurearrivee, pe.tempspenalite;


ALTER TABLE public.v_coureuretapeclassementpenalite OWNER TO postgres;

--
-- Name: v_coureurrangpenalite; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_coureurrangpenalite AS
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
   FROM (public.v_coureuretapeclassementpenalite vc
     LEFT JOIN public.pointrang r ON ((vc.classement = r.classement)))
  ORDER BY vc.idetape, vc.classement;


ALTER TABLE public.v_coureurrangpenalite OWNER TO postgres;

--
-- Name: v_classementindividuelpenalite; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementindividuelpenalite AS
 SELECT v_coureurrangpenalite.idcoureur,
    v_coureurrangpenalite.nomcoureur,
    c.numero,
    e.nomequipe,
    dense_rank() OVER (ORDER BY (sum(v_coureurrangpenalite.points)) DESC) AS rang,
    sum(v_coureurrangpenalite.points) AS points
   FROM ((public.v_coureurrangpenalite
     JOIN public.coureur c ON ((c.idcoureur = v_coureurrangpenalite.idcoureur)))
     JOIN public.equipe e ON ((e.idequipe = c.idequipe)))
  GROUP BY v_coureurrangpenalite.idcoureur, v_coureurrangpenalite.nomcoureur, c.numero, e.nomequipe;


ALTER TABLE public.v_classementindividuelpenalite OWNER TO postgres;

--
-- Name: v_classementequipe; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementequipe AS
 SELECT e.idequipe,
    e.nomequipe,
    sum(vci.points) AS points,
    dense_rank() OVER (ORDER BY (sum(vci.points)) DESC) AS rang
   FROM ((public.v_classementindividuelpenalite vci
     JOIN public.coureur c ON ((c.idcoureur = vci.idcoureur)))
     JOIN public.equipe e ON ((e.idequipe = c.idequipe)))
  GROUP BY e.idequipe, e.nomequipe;


ALTER TABLE public.v_classementequipe OWNER TO postgres;

--
-- Name: v_classementgeneralequipecategorie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementgeneralequipecategorie AS
 SELECT eq.nomequipe,
    cat.idcategorie,
    cat.nomcategorie,
    sum(pr.points) AS totalpoints,
    dense_rank() OVER (PARTITION BY cat.idcategorie ORDER BY (sum(pr.points)) DESC) AS classementequipe
   FROM ((((( SELECT ce.idetape,
            cc.idcategorie,
            ce.idcoureur,
            date_part('epoch'::text, (ce.dateheurearrivee - min(ce.dateheurearrivee) OVER (PARTITION BY ce.idetape, cc.idcategorie))) AS difftemps,
            dense_rank() OVER (PARTITION BY ce.idetape, cc.idcategorie ORDER BY ce.dateheurearrivee) AS classement
           FROM (public.coureuretape ce
             JOIN public.categoriecoureur cc ON ((ce.idcoureur = cc.idcoureur)))) sub
     JOIN public.pointrang pr ON ((sub.classement = pr.classement)))
     JOIN public.coureur c ON ((sub.idcoureur = c.idcoureur)))
     JOIN public.equipe eq ON ((c.idequipe = eq.idequipe)))
     JOIN public.categorie cat ON ((sub.idcategorie = cat.idcategorie)))
  GROUP BY eq.nomequipe, cat.idcategorie, cat.nomcategorie;


ALTER TABLE public.v_classementgeneralequipecategorie OWNER TO postgres;

--
-- Name: v_classementgeneralequipecategoriepenalite; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_classementgeneralequipecategoriepenalite AS
 SELECT eq.nomequipe,
    cat.idcategorie,
    cat.nomcategorie,
    sum(pr.points) AS totalpoints,
    dense_rank() OVER (PARTITION BY cat.idcategorie ORDER BY (sum(pr.points)) DESC) AS classementequipe
   FROM ((((( SELECT ce.idetape,
            cc.idcategorie,
            ce.idcoureur,
            date_part('epoch'::text, ((ce.dateheurearrivee + COALESCE((pe.tempspenalite)::interval, '00:00:00'::interval)) - min((ce.dateheurearrivee + COALESCE((pe.tempspenalite)::interval, '00:00:00'::interval))) OVER (PARTITION BY ce.idetape, cc.idcategorie))) AS difftemps,
            dense_rank() OVER (PARTITION BY ce.idetape, cc.idcategorie ORDER BY (ce.dateheurearrivee + COALESCE((pe.tempspenalite)::interval, '00:00:00'::interval))) AS classement
           FROM ((public.coureuretape ce
             JOIN public.categoriecoureur cc ON ((ce.idcoureur = cc.idcoureur)))
             LEFT JOIN public.penaliteequipe pe ON (((ce.idetape = pe.idetape) AND (ce.idcoureur IN ( SELECT coureur.idcoureur
                   FROM public.coureur
                  WHERE (coureur.idequipe = pe.idequipe))))))) sub
     JOIN public.pointrang pr ON ((sub.classement = pr.classement)))
     JOIN public.coureur c ON ((sub.idcoureur = c.idcoureur)))
     JOIN public.equipe eq ON ((c.idequipe = eq.idequipe)))
     JOIN public.categorie cat ON ((sub.idcategorie = cat.idcategorie)))
  GROUP BY eq.nomequipe, cat.idcategorie, cat.nomcategorie;


ALTER TABLE public.v_classementgeneralequipecategoriepenalite OWNER TO postgres;

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
    dense_rank() OVER (PARTITION BY ce.idetape ORDER BY (ce.dateheurearrivee - e.dateheuredepart)) AS classement
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
-- Name: v_etapeequipe; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_etapeequipe AS
 SELECT e.nometape,
    e.longueur,
    e.nbrcoureurequipe,
    ce.idetape,
    c.idequipe
   FROM ((public.coureuretape ce
     JOIN public.etape e ON ((e.idetape = ce.idetape)))
     JOIN public.coureur c ON ((c.idcoureur = ce.idcoureur)))
  GROUP BY e.nometape, e.longueur, e.nbrcoureurequipe, ce.idetape, c.idequipe;


ALTER TABLE public.v_etapeequipe OWNER TO postgres;

--
-- Name: v_nbrcoureurassignableetape; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_nbrcoureurassignableetape AS
 SELECT ce.idetape,
    e.nometape,
    e.nbrcoureurequipe,
    count(ce.idcoureur) AS nombrecoureurinscrit,
    (e.nbrcoureurequipe - count(ce.idcoureur)) AS nombrecoureurrestant
   FROM (public.etape e
     LEFT JOIN public.coureuretape ce ON ((e.idetape = ce.idetape)))
  GROUP BY ce.idetape, e.nometape, e.nbrcoureurequipe;


ALTER TABLE public.v_nbrcoureurassignableetape OWNER TO postgres;

--
-- Name: v_penaliteequipe; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_penaliteequipe AS
 SELECT et.idetape,
    et.nometape,
    e.idequipe,
    e.nomequipe,
    pe.tempspenalite
   FROM ((public.penaliteequipe pe
     JOIN public.equipe e ON ((e.idequipe = pe.idequipe)))
     JOIN public.etape et ON ((et.idetape = pe.idetape)));


ALTER TABLE public.v_penaliteequipe OWNER TO postgres;

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
\.


--
-- Data for Name: categoriecoureur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categoriecoureur (idcoureur, idcategorie) FROM stdin;
277	1
278	1
279	1
280	1
280	3
281	1
282	1
283	2
284	1
285	2
286	2
287	1
288	1
289	2
289	3
290	2
291	2
292	1
293	2
294	1
295	2
296	1
296	3
\.


--
-- Data for Name: coureur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coureur (idcoureur, nomcoureur, numero, datenaissance, idequipe, genre) FROM stdin;
277	Zo	3	1963-11-18	156	M
278	Nofy	17	1979-04-20	159	M
279	Niry	18	1979-06-01	155	M
280	Fara	13	2008-01-23	158	M
281	Koto	15	1983-08-29	157	M
282	Solo	4	1982-07-07	155	M
283	Miora	20	1961-08-13	156	F
284	Zara	8	1979-10-16	156	M
285	Hasina	5	1998-06-11	159	F
286	Lova	11	1994-09-01	157	F
287	Hery	7	1979-04-08	156	M
288	Andry	14	1997-09-24	157	M
289	Rina	16	2010-04-23	155	F
290	Tiana	1	1959-10-05	158	F
291	Faniry	2	1955-07-03	157	F
292	Mamy	12	1982-11-29	158	M
293	Rado	9	1990-12-11	155	F
294	Lalao	19	1997-06-21	156	M
295	Tahina	10	1972-12-20	159	F
296	Tina	6	2007-01-04	158	M
\.


--
-- Data for Name: coureuretape; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coureuretape (idetape, idcoureur, dateheurearrivee) FROM stdin;
21	293	2024-06-01 14:40:16
22	293	2024-06-02 00:22:36
23	293	2024-06-02 11:17:19
24	293	2024-06-02 13:20:44
22	289	2024-06-01 23:50:18
24	289	2024-06-02 13:20:44
20	282	2024-06-01 10:01:34
21	279	2024-06-01 14:15:09
23	279	2024-06-02 11:20:02
21	294	2024-06-01 14:31:58
23	294	2024-06-02 11:12:46
21	287	2024-06-01 14:15:09
22	287	2024-06-02 00:27:50
24	287	2024-06-02 13:52:50
22	284	2024-06-02 00:40:08
24	284	2024-06-02 13:43:08
22	283	2024-06-01 23:47:44
20	277	2024-06-01 09:55:21
20	291	2024-06-01 09:54:03
24	291	2024-06-02 13:38:11
21	288	2024-06-01 14:02:35
22	288	2024-06-01 23:55:47
23	288	2024-06-02 11:11:08
22	286	2024-06-01 23:45:32
23	286	2024-06-02 11:13:33
21	281	2024-06-01 14:37:47
22	281	2024-06-01 23:52:11
21	296	2024-06-01 14:08:12
23	296	2024-06-02 11:14:55
24	296	2024-06-02 14:01:23
21	292	2024-06-01 14:45:23
23	292	2024-06-02 11:16:29
20	290	2024-06-01 10:01:34
22	290	2024-06-02 00:31:23
22	280	2024-06-02 00:04:19
24	280	2024-06-02 13:26:19
21	295	2024-06-01 14:15:09
23	295	2024-06-02 11:19:58
20	285	2024-06-01 10:07:29
22	285	2024-06-02 00:12:09
23	285	2024-06-02 11:10:41
21	278	2024-06-01 14:23:11
22	278	2024-06-01 23:56:53
24	278	2024-06-02 13:21:18
20	281	\N
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
155	D		
156	C		
158	B		
159	E		
157	A	ea@gmail.com	ea
\.


--
-- Data for Name: etape; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.etape (idetape, nometape, longueur, nbrcoureurequipe, dateheuredepart, rang) FROM stdin;
20	Betsirazaina	8.60	1	2024-06-01 09:00:00	1
21	Ampasimbe	18.21	2	2024-06-01 13:15:00	2
22	Ambatobe	13.09	3	2024-06-01 23:35:00	3
23	Ilafy	4.44	2	2024-06-02 11:00:00	4
24	Ambatobe	22.89	2	2024-06-02 12:05:00	5
\.


--
-- Data for Name: penaliteequipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.penaliteequipe (idetape, idequipe, tempspenalite) FROM stdin;
20	157	09:50:03
21	157	09:50:03
\.


--
-- Data for Name: pointrang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pointrang (idrang, classement, points) FROM stdin;
11	4	2
12	3	4
13	1	10
14	2	6
15	5	1
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

SELECT pg_catalog.setval('public.coureur_idcoureur_seq', 296, true);


--
-- Name: course_idcourse_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_idcourse_seq', 1, true);


--
-- Name: equipe_idequipe_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.equipe_idequipe_seq', 159, true);


--
-- Name: etape_idetape_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.etape_idetape_seq', 24, true);


--
-- Name: pointrang_idrang_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pointrang_idrang_seq', 15, true);


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
-- Name: etape etape_rang_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.etape
    ADD CONSTRAINT etape_rang_key UNIQUE (rang);


--
-- Name: penaliteequipe penaliteequipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.penaliteequipe
    ADD CONSTRAINT penaliteequipe_pkey PRIMARY KEY (idetape, idequipe);


--
-- Name: pointrang pointrang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pointrang
    ADD CONSTRAINT pointrang_pkey PRIMARY KEY (idrang);


--
-- Name: equipe uniquenomequipe; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipe
    ADD CONSTRAINT uniquenomequipe UNIQUE (nomequipe);


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
-- Name: penaliteequipe penaliteequipe_idequipe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.penaliteequipe
    ADD CONSTRAINT penaliteequipe_idequipe_fkey FOREIGN KEY (idequipe) REFERENCES public.equipe(idequipe);


--
-- Name: penaliteequipe penaliteequipe_idetape_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.penaliteequipe
    ADD CONSTRAINT penaliteequipe_idetape_fkey FOREIGN KEY (idetape) REFERENCES public.etape(idetape);


--
-- PostgreSQL database dump complete
--

