--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.4

-- Started on 2024-08-29 12:14:28

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 114754)
-- Name: bodegas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bodegas (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.bodegas OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 114753)
-- Name: bodegas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bodegas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bodegas_id_seq OWNER TO postgres;

--
-- TOC entry 4823 (class 0 OID 0)
-- Dependencies: 215
-- Name: bodegas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bodegas_id_seq OWNED BY public.bodegas.id;


--
-- TOC entry 220 (class 1259 OID 114773)
-- Name: monedas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.monedas (
    id integer NOT NULL,
    nombre character varying(10) NOT NULL,
    simbolo character varying(5) NOT NULL
);


ALTER TABLE public.monedas OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 114772)
-- Name: monedas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.monedas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.monedas_id_seq OWNER TO postgres;

--
-- TOC entry 4824 (class 0 OID 0)
-- Dependencies: 219
-- Name: monedas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.monedas_id_seq OWNED BY public.monedas.id;


--
-- TOC entry 222 (class 1259 OID 114780)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    codigo character varying(15) NOT NULL,
    nombre character varying(50) NOT NULL,
    precio numeric(10,2) NOT NULL,
    descripcion text NOT NULL,
    materiales text[] NOT NULL,
    bodega_id integer,
    sucursal_id integer,
    moneda_id integer
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 114779)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- TOC entry 4825 (class 0 OID 0)
-- Dependencies: 221
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- TOC entry 218 (class 1259 OID 114761)
-- Name: sucursales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursales (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    bodega_id integer
);


ALTER TABLE public.sucursales OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 114760)
-- Name: sucursales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sucursales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sucursales_id_seq OWNER TO postgres;

--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 217
-- Name: sucursales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sucursales_id_seq OWNED BY public.sucursales.id;


--
-- TOC entry 4649 (class 2604 OID 114757)
-- Name: bodegas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodegas ALTER COLUMN id SET DEFAULT nextval('public.bodegas_id_seq'::regclass);


--
-- TOC entry 4651 (class 2604 OID 114776)
-- Name: monedas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monedas ALTER COLUMN id SET DEFAULT nextval('public.monedas_id_seq'::regclass);


--
-- TOC entry 4652 (class 2604 OID 114783)
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- TOC entry 4650 (class 2604 OID 114764)
-- Name: sucursales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales ALTER COLUMN id SET DEFAULT nextval('public.sucursales_id_seq'::regclass);


--
-- TOC entry 4811 (class 0 OID 114754)
-- Dependencies: 216
-- Data for Name: bodegas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bodegas (id, nombre) FROM stdin;
1	Bodega Central
2	Bodega Norte
3	Bodega Sur
\.


--
-- TOC entry 4815 (class 0 OID 114773)
-- Dependencies: 220
-- Data for Name: monedas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.monedas (id, nombre, simbolo) FROM stdin;
1	Dólar	$
2	Sol	S/
3	Euro	€
\.


--
-- TOC entry 4817 (class 0 OID 114780)
-- Dependencies: 222
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, codigo, nombre, precio, descripcion, materiales, bodega_id, sucursal_id, moneda_id) FROM stdin;
1	A1B2C3	PRODUCTO EJEMPLO	15.00	Elegante set de comedor de madera natural, incluye mesa y sillas. Dise&ntilde;o cl&aacute;sico y duradero, ideal para cualquier estilo de decoraci&oacute;n. Perfecto para cenas familiares y reuniones sociales.	{Plástico,Metal,Madera}	3	4	1
4	A4B4C7	NIÑO E INGLÉS	150.00	Elegante set de comedor de madera natural, incluye mesa y sillas. Diseño clásico y duradero, ideal para cualquier estilo de decoración. Perfecto para cenas familiares y reuniones sociales.	{Plástico,Metal}	1	1	1
2	A2B3C4	PRODUCTO	105.00	Elegante set de comedor de madera natural, incluye mesa y sillas. Dise&ntilde;o cl&aacute;sico y duradero, ideal para cualquier estilo de decoraci&oacute;n. Perfecto para cenas familiares y reuniones sociales.	{Plástico,Metal,Madera,Vidrio,Textil}	2	3	3
3	A3B4C5	PRODUCTO	1478.00	Elegante set de comedor de madera natural, incluye mesa y sillas. Dise&ntilde;o cl&aacute;sico y duradero, ideal para cualquier estilo de decoraci&oacute;n. Perfecto para cenas familiares y reuniones sociales.	{Plástico,Metal,Textil}	1	1	2
\.


--
-- TOC entry 4813 (class 0 OID 114761)
-- Dependencies: 218
-- Data for Name: sucursales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sucursales (id, nombre, bodega_id) FROM stdin;
1	Sucursal A	1
2	Sucursal B	1
3	Sucursal C	2
4	Sucursal D	3
\.


--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 215
-- Name: bodegas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bodegas_id_seq', 6, true);


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 219
-- Name: monedas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.monedas_id_seq', 3, true);


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 221
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 4, true);


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 217
-- Name: sucursales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sucursales_id_seq', 8, true);


--
-- TOC entry 4654 (class 2606 OID 114759)
-- Name: bodegas bodegas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bodegas
    ADD CONSTRAINT bodegas_pk PRIMARY KEY (id);


--
-- TOC entry 4658 (class 2606 OID 114778)
-- Name: monedas monedas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.monedas
    ADD CONSTRAINT monedas_pk PRIMARY KEY (id);


--
-- TOC entry 4660 (class 2606 OID 114789)
-- Name: productos productos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_codigo_key UNIQUE (codigo);


--
-- TOC entry 4662 (class 2606 OID 114787)
-- Name: productos productos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pk PRIMARY KEY (id);


--
-- TOC entry 4656 (class 2606 OID 114766)
-- Name: sucursales sucursales_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_pk PRIMARY KEY (id);


--
-- TOC entry 4664 (class 2606 OID 114790)
-- Name: productos productos_bodega_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_bodega_id_fkey FOREIGN KEY (bodega_id) REFERENCES public.bodegas(id);


--
-- TOC entry 4665 (class 2606 OID 114800)
-- Name: productos productos_moneda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_moneda_id_fkey FOREIGN KEY (moneda_id) REFERENCES public.monedas(id);


--
-- TOC entry 4666 (class 2606 OID 114795)
-- Name: productos productos_sucursal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_sucursal_id_fkey FOREIGN KEY (sucursal_id) REFERENCES public.sucursales(id);


--
-- TOC entry 4663 (class 2606 OID 114767)
-- Name: sucursales sucursales_bodega_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursales
    ADD CONSTRAINT sucursales_bodega_id_fkey FOREIGN KEY (bodega_id) REFERENCES public.bodegas(id);


-- Completed on 2024-08-29 12:14:28

--
-- PostgreSQL database dump complete
--

