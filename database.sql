--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

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
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    writer character varying(255) NOT NULL,
    cover_image character varying(255) DEFAULT 'https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg'::character varying NOT NULL,
    point numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.books OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO postgres;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: books_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books_tags (
    books_id bigint NOT NULL,
    tags_id bigint NOT NULL
);


ALTER TABLE public.books_tags OWNER TO postgres;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    book_id bigint NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    points_deducted numeric(10,2) NOT NULL,
    cancelled boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: points; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.points (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    points numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.points OWNER TO postgres;

--
-- Name: points_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.points_id_seq OWNER TO postgres;

--
-- Name: points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.points_id_seq OWNED BY public.points.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    slug character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tags_id_seq OWNER TO postgres;

--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: points id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.points ALTER COLUMN id SET DEFAULT nextval('public.points_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, title, writer, cover_image, point, created_at, updated_at) FROM stdin;
128	Quidem quis laboriosam.	Ila Dickinson	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	50.00	2024-04-28 12:01:19	2024-04-28 12:01:19
129	Et quia et suscipit.	Dr. Jayce Sporer Jr.	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	21.00	2024-04-28 12:01:19	2024-04-28 12:01:19
130	Reprehenderit fugit consequatur fugiat.	Felix Lindgren	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	100.00	2024-04-28 12:01:19	2024-04-28 12:01:19
131	Corrupti atque at et.	Dee Torphy	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	81.00	2024-04-28 12:01:19	2024-04-28 12:01:19
132	Eos dolore minima.	Nelda Muller	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	1.00	2024-04-28 12:01:19	2024-04-28 12:01:19
133	Nihil voluptatem a.	Darryl Parker	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	67.00	2024-04-28 12:01:19	2024-04-28 12:01:19
134	Aperiam debitis.	Catalina Dickinson	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	57.00	2024-04-28 12:01:19	2024-04-28 12:01:19
135	Consectetur aut tempora perferendis.	Justina Koepp	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	25.00	2024-04-28 12:01:19	2024-04-28 12:01:19
136	Fugiat vitae ea.	Mrs. Karelle Marks DDS	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	84.00	2024-04-28 12:01:19	2024-04-28 12:01:19
137	Necessitatibus tempora praesentium officia nemo.	Ebba Swift	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	73.00	2024-04-28 12:01:19	2024-04-28 12:01:19
138	Non ea necessitatibus.	Prof. Jeremie Leffler MD	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	64.00	2024-04-28 12:01:19	2024-04-28 12:01:19
139	Omnis atque non ratione qui.	Prof. Mauricio Metz	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	100.00	2024-04-28 12:01:19	2024-04-28 12:01:19
140	Debitis nam soluta temporibus voluptates.	George Larkin	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	35.00	2024-04-28 12:01:19	2024-04-28 12:01:19
141	Eveniet dolore quisquam porro.	Esmeralda Schimmel	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	37.00	2024-04-28 12:01:19	2024-04-28 12:01:19
142	Aut perspiciatis officiis.	Dakota Lowe MD	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	71.00	2024-04-28 12:01:19	2024-04-28 12:01:19
143	Ducimus ipsum.	Mr. Gerald Zieme DVM	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	37.00	2024-04-28 12:01:19	2024-04-28 12:01:19
144	Illum nesciunt maiores aut.	Delaney Kulas	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	95.00	2024-04-28 12:01:19	2024-04-28 12:01:19
145	Nihil alias quidem.	Dr. Alexie Hane I	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	30.00	2024-04-28 12:01:19	2024-04-28 12:01:19
146	Qui est harum.	Patricia Schmidt	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	20.00	2024-04-28 12:01:19	2024-04-28 12:01:19
147	Eius sit aut.	Sid Langosh	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	85.00	2024-04-28 12:01:19	2024-04-28 12:01:19
148	Voluptatibus ut dolor.	Rebeka Rolfson	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	25.00	2024-04-28 12:01:19	2024-04-28 12:01:19
149	Aliquid dignissimos at.	Alberto Wolff	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	50.00	2024-04-28 12:01:19	2024-04-28 12:01:19
150	Necessitatibus voluptatem harum dolore.	Adrien Beatty	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	42.00	2024-04-28 12:01:19	2024-04-28 12:01:19
151	Consequatur voluptas corporis eveniet.	Miss Betsy Tromp	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	89.00	2024-04-28 12:01:19	2024-04-28 12:01:19
152	Atque cumque et.	Abagail Lind	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	25.00	2024-04-28 12:01:19	2024-04-28 12:01:19
153	Excepturi quam repellendus.	Jakob Bradtke	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	98.00	2024-04-28 12:01:19	2024-04-28 12:01:19
154	Labore atque incidunt sit.	Wilson Wintheiser V	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	66.00	2024-04-28 12:01:19	2024-04-28 12:01:19
155	Reiciendis deleniti quidem.	Jordy Harber	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	68.00	2024-04-28 12:01:19	2024-04-28 12:01:19
156	Sequi provident mollitia.	Kylie Hansen	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	45.00	2024-04-28 12:01:19	2024-04-28 12:01:19
157	Est consectetur maxime.	Twila Mills	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	46.00	2024-04-28 12:01:19	2024-04-28 12:01:19
158	Error ab corrupti veniam.	Dr. Arturo Greenholt	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	88.00	2024-04-28 12:01:19	2024-04-28 12:01:19
159	Iure ipsa mollitia sed.	Christelle Funk	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	24.00	2024-04-28 12:01:19	2024-04-28 12:01:19
160	Aut necessitatibus ut fuga.	Marina Johnson	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	58.00	2024-04-28 12:01:19	2024-04-28 12:01:19
161	Cum rerum delectus quidem.	Arjun Champlin II	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	90.00	2024-04-28 12:01:19	2024-04-28 12:01:19
162	Aperiam quo sit dignissimos voluptas.	Prof. Eloise Grant V	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	77.00	2024-04-28 12:01:19	2024-04-28 12:01:19
163	Ab maiores aut.	Tomasa Auer	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	56.00	2024-04-28 12:01:19	2024-04-28 12:01:19
164	Quo laborum itaque sapiente ducimus.	Mrs. Cora Ebert	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	6.00	2024-04-28 12:01:19	2024-04-28 12:01:19
165	Hic eaque.	Maximus Casper	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	74.00	2024-04-28 12:01:19	2024-04-28 12:01:19
166	Quas dicta nostrum nihil.	Mrs. Mina Pfeffer DDS	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	31.00	2024-04-28 12:01:19	2024-04-28 12:01:19
167	Officia tempora fugit.	Michelle Runte	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	3.00	2024-04-28 12:01:19	2024-04-28 12:01:19
168	Dolorum quo sed enim maiores.	Mia Haley MD	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	20.00	2024-04-28 12:01:19	2024-04-28 12:01:19
169	Est veritatis aliquam deleniti.	Mrs. Teresa Wolff	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	62.00	2024-04-28 12:01:19	2024-04-28 12:01:19
170	Ipsa eos minima.	Mr. Zack Jast	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	81.00	2024-04-28 12:01:19	2024-04-28 12:01:19
171	Molestiae eius sed.	Lou Shanahan	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	77.00	2024-04-28 12:01:19	2024-04-28 12:01:19
172	Quibusdam mollitia quas.	Ralph Hintz	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	21.00	2024-04-28 12:01:19	2024-04-28 12:01:19
173	Occaecati doloremque placeat mollitia.	Mafalda Bashirian	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	21.00	2024-04-28 12:01:19	2024-04-28 12:01:19
174	Et quia.	Mr. Jason Graham Sr.	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	25.00	2024-04-28 12:01:19	2024-04-28 12:01:19
175	Atque asperiores facere.	Megane Haley	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	73.00	2024-04-28 12:01:19	2024-04-28 12:01:19
176	Quibusdam repudiandae corrupti.	Janie Dare	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	8.00	2024-04-28 12:01:19	2024-04-28 12:01:19
177	Deleniti dolore voluptatum.	Pamela Dickens	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	60.00	2024-04-28 12:01:19	2024-04-28 12:01:19
178	Sunt voluptas dolores commodi non.	Tamara Gulgowski III	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	60.00	2024-04-28 12:01:19	2024-04-28 12:01:19
179	Ut vitae illum.	Dr. Ova Lind	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	12.00	2024-04-28 12:01:19	2024-04-28 12:01:19
180	Iure autem molestiae quaerat.	Deonte Dickinson DDS	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	69.00	2024-04-28 12:01:19	2024-04-28 12:01:19
181	Quibusdam reprehenderit consequatur facere ad.	Ethelyn Gutkowski	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	73.00	2024-04-28 12:01:19	2024-04-28 12:01:19
182	Natus maxime ipsam.	Mr. Guiseppe Pagac	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	40.00	2024-04-28 12:01:19	2024-04-28 12:01:19
183	Ratione cupiditate necessitatibus suscipit.	Rebecca Orn	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	42.00	2024-04-28 12:01:19	2024-04-28 12:01:19
184	Libero asperiores voluptas.	Mr. Orlando Beahan DVM	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	39.00	2024-04-28 12:01:19	2024-04-28 12:01:19
185	Atque doloribus ex.	Delta Little	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	14.00	2024-04-28 12:01:19	2024-04-28 12:01:19
186	Est molestiae.	Elouise Dietrich	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	55.00	2024-04-28 12:01:19	2024-04-28 12:01:19
187	Omnis nulla et.	Olga Kiehn	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	45.00	2024-04-28 12:01:19	2024-04-28 12:01:19
188	Culpa consectetur ullam quisquam.	Cleo Hermann	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	62.00	2024-04-28 12:01:19	2024-04-28 12:01:19
189	Odit quae.	Billie Treutel	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	52.00	2024-04-28 12:01:19	2024-04-28 12:01:19
190	Ipsa voluptatibus quia voluptatem.	Prof. Mozelle Schneider	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	24.00	2024-04-28 12:01:19	2024-04-28 12:01:19
191	Aperiam dolore aut.	Edmund Powlowski	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	9.00	2024-04-28 12:01:19	2024-04-28 12:01:19
192	Eum ut velit.	Edgar Schowalter Jr.	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	34.00	2024-04-28 12:01:19	2024-04-28 12:01:19
193	Cupiditate rerum.	Giovanna Corwin	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	81.00	2024-04-28 12:01:19	2024-04-28 12:01:19
194	Accusamus nulla ut est.	Ms. Maggie Tromp	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	56.00	2024-04-28 12:01:19	2024-04-28 12:01:19
195	Expedita exercitationem est blanditiis.	Haven Ritchie	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	16.00	2024-04-28 12:01:19	2024-04-28 12:01:19
196	Ex qui architecto.	Remington Kuphal	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	16.00	2024-04-28 12:01:19	2024-04-28 12:01:19
197	Cupiditate alias asperiores.	Bettie Mills	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	95.00	2024-04-28 12:01:19	2024-04-28 12:01:19
198	Nemo soluta dolores.	Trever Schamberger II	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	29.00	2024-04-28 12:01:19	2024-04-28 12:01:19
199	Corporis eum velit.	Obie Sanford	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	50.00	2024-04-28 12:01:19	2024-04-28 12:01:19
200	Cupiditate sunt adipisci.	Lavina Russel	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	38.00	2024-04-28 12:01:19	2024-04-28 12:01:19
201	Eum ut.	Prof. Otha Padberg	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	59.00	2024-04-28 12:01:19	2024-04-28 12:01:19
202	Magni a ut.	Prof. Marge Predovic	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	80.00	2024-04-28 12:01:19	2024-04-28 12:01:19
203	Repellendus sunt qui sapiente ipsa.	Prof. Esmeralda Jacobs	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	44.00	2024-04-28 12:01:19	2024-04-28 12:01:19
204	Ut accusamus accusantium possimus.	Vidal Weber MD	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	23.00	2024-04-28 12:01:19	2024-04-28 12:01:19
205	Qui repellat non.	Ewald Gulgowski II	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	43.00	2024-04-28 12:01:19	2024-04-28 12:01:19
206	Corrupti enim et.	Alex Wiegand DVM	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	78.00	2024-04-28 12:01:19	2024-04-28 12:01:19
207	Et iusto aspernatur.	Dr. Harrison Reichel MD	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	60.00	2024-04-28 12:01:19	2024-04-28 12:01:19
208	Sit dolorum numquam.	Kathryn Ortiz IV	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	80.00	2024-04-28 12:01:19	2024-04-28 12:01:19
209	Accusantium blanditiis et.	Mr. Raheem Ernser	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	65.00	2024-04-28 12:01:19	2024-04-28 12:01:19
210	Ut voluptatibus perspiciatis.	Mrs. Nedra Breitenberg	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	71.00	2024-04-28 12:01:19	2024-04-28 12:01:19
211	Quia eos omnis tempore occaecati.	Felix Sauer	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	75.00	2024-04-28 12:01:19	2024-04-28 12:01:19
212	Quam ea maiores.	Westley Kub	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	35.00	2024-04-28 12:01:19	2024-04-28 12:01:19
213	Ut nemo deleniti.	Emery Morissette	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	45.00	2024-04-28 12:01:19	2024-04-28 12:01:19
214	Voluptas molestiae impedit praesentium.	Mr. Jacey Hegmann DDS	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	80.00	2024-04-28 12:01:19	2024-04-28 12:01:19
215	Commodi nulla sit aut.	Leonor Sanford	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	27.00	2024-04-28 12:01:19	2024-04-28 12:01:19
216	Ut excepturi beatae omnis.	Albertha Gusikowski	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	58.00	2024-04-28 12:01:19	2024-04-28 12:01:19
217	Nihil dignissimos quae qui mollitia.	Mrs. Mona Nitzsche	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	31.00	2024-04-28 12:01:19	2024-04-28 12:01:19
218	Atque sed consequatur.	Daren Hudson	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	18.00	2024-04-28 12:01:19	2024-04-28 12:01:19
219	Non officia velit tenetur asperiores.	Furman Schimmel	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	59.00	2024-04-28 12:01:19	2024-04-28 12:01:19
220	Corporis voluptas tempora fugiat.	Jaron Mosciski	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	40.00	2024-04-28 12:01:19	2024-04-28 12:01:19
221	Adipisci tenetur molestiae dolorum.	Orin Kihn	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	99.00	2024-04-28 12:01:19	2024-04-28 12:01:19
222	Dolor ut aut tenetur.	Dr. Aidan Russel Sr.	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	69.00	2024-04-28 12:01:19	2024-04-28 12:01:19
223	Iusto omnis ea iure.	Prof. Faustino McLaughlin DVM	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	7.00	2024-04-28 12:01:19	2024-04-28 12:01:19
224	Magni velit tempore.	Dr. Kristian Terry	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	40.00	2024-04-28 12:01:19	2024-04-28 12:01:19
225	Quis facilis.	Pearl Smith	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	90.00	2024-04-28 12:01:19	2024-04-28 12:01:19
226	Quia fugiat sit suscipit.	Esmeralda Considine	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	60.00	2024-04-28 12:01:19	2024-04-28 12:01:19
227	test	test	https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg	2.00	2024-04-28 12:01:19	2024-04-28 13:08:35
\.


--
-- Data for Name: books_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books_tags (books_id, tags_id) FROM stdin;
128	25
128	22
128	23
129	24
129	22
129	26
130	21
130	23
130	26
131	24
131	20
131	22
132	24
132	19
132	22
133	20
133	23
133	26
134	20
134	22
134	26
135	24
135	19
135	20
136	24
136	25
136	26
137	25
137	19
137	20
138	24
138	26
138	27
139	19
139	21
139	27
140	22
140	23
140	27
141	24
141	22
141	26
142	24
142	25
142	23
143	20
143	21
143	23
144	25
144	23
144	27
145	19
145	21
145	27
146	19
146	22
146	21
147	19
147	20
147	23
148	25
148	20
148	21
149	20
149	22
149	23
150	24
150	19
150	21
151	23
151	26
151	27
152	24
152	19
152	20
153	22
153	23
153	26
154	22
154	21
154	23
155	24
155	19
155	26
156	24
156	26
156	27
157	22
157	21
157	27
158	23
158	26
158	27
159	25
159	23
159	26
160	19
160	20
160	23
161	24
161	21
161	26
162	25
162	21
162	27
163	20
163	22
163	27
164	24
164	19
164	26
165	19
165	23
165	27
166	24
166	26
166	27
167	19
167	20
167	21
168	19
168	20
168	26
169	25
169	19
169	27
170	19
170	22
170	27
171	19
171	26
171	27
172	19
172	21
172	23
173	20
173	23
173	27
174	25
174	23
174	26
175	25
175	22
175	27
176	19
176	26
176	27
177	25
177	21
177	26
178	24
178	25
178	26
179	23
179	26
179	27
180	21
180	23
180	26
181	24
181	23
181	27
182	19
182	26
182	27
183	25
183	20
183	22
184	20
184	22
184	27
185	21
185	23
185	27
186	21
186	26
186	27
187	20
187	23
187	27
188	24
188	20
188	21
189	22
189	23
189	26
190	24
190	25
190	23
191	24
191	20
191	21
192	19
192	21
192	27
193	24
193	25
193	23
194	19
194	22
194	26
195	24
195	22
195	27
196	19
196	20
196	27
197	24
197	25
197	21
198	25
198	22
198	27
199	19
199	21
199	26
200	19
200	22
200	23
201	25
201	22
201	23
202	20
202	22
202	26
203	25
203	21
203	26
204	24
204	23
204	26
205	25
205	22
205	23
206	24
206	25
206	27
207	20
207	22
207	27
208	22
208	21
208	23
209	22
209	23
209	27
210	20
210	22
210	21
211	25
211	19
211	21
212	24
212	25
212	26
213	25
213	23
213	27
214	24
214	22
214	27
215	20
215	21
215	23
216	24
216	20
216	26
217	24
217	25
217	22
218	25
218	21
218	23
219	25
219	20
219	27
220	24
220	25
220	23
221	24
221	26
221	27
222	25
222	19
222	27
223	22
223	21
223	23
224	24
224	19
224	26
225	20
225	26
225	27
226	24
226	26
226	27
227	19
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_04_27_033438_create_books_table	1
5	2024_04_27_033531_create_tags_table	1
6	2024_04_27_033602_create_book_tag_table	1
14	2024_04_28_092826_create_orders_table	1
7	2024_04_27_080029_create_personal_access_tokens_table	1
9	2024_04_27_033602_create_books_tags_table	1
15	2024_04_28_070944_create_points_table	2
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, book_id, total_amount, points_deducted, cancelled, created_at, updated_at) FROM stdin;
7	5	167	45.00	45.00	t	2024-04-28 12:07:35	2024-04-28 12:07:42
8	5	132	44.00	44.00	f	2024-04-28 12:08:22	2024-04-28 12:08:22
9	5	132	43.00	43.00	f	2024-04-28 12:08:27	2024-04-28 12:08:27
10	5	132	42.00	42.00	f	2024-04-28 12:08:31	2024-04-28 12:08:31
11	5	132	41.00	41.00	f	2024-04-28 12:08:35	2024-04-28 12:08:35
12	5	132	40.00	40.00	f	2024-04-28 12:08:38	2024-04-28 12:08:38
13	5	132	39.00	39.00	f	2024-04-28 12:08:42	2024-04-28 12:08:42
14	3	132	18.60	18.60	f	2024-04-28 12:09:10	2024-04-28 12:09:10
15	3	132	17.60	17.60	f	2024-04-28 12:09:11	2024-04-28 12:09:11
16	3	132	16.60	16.60	f	2024-04-28 12:09:12	2024-04-28 12:09:12
17	3	132	15.60	15.60	f	2024-04-28 12:09:12	2024-04-28 12:09:12
18	5	132	38.00	38.00	f	2024-04-28 12:09:16	2024-04-28 12:09:16
19	3	132	14.60	14.60	f	2024-04-28 12:09:24	2024-04-28 12:09:24
20	3	132	13.60	13.60	f	2024-04-28 12:10:05	2024-04-28 12:10:05
21	3	132	12.60	12.60	f	2024-04-28 12:10:13	2024-04-28 12:10:13
22	3	132	11.60	11.60	f	2024-04-28 12:10:14	2024-04-28 12:10:14
23	3	132	10.60	10.60	f	2024-04-28 12:10:15	2024-04-28 12:10:15
24	3	132	9.60	9.60	f	2024-04-28 12:10:16	2024-04-28 12:10:16
25	3	132	8.60	8.60	f	2024-04-28 12:10:17	2024-04-28 12:10:17
26	3	132	7.60	7.60	f	2024-04-28 12:10:17	2024-04-28 12:10:17
27	3	132	6.60	6.60	f	2024-04-28 12:10:18	2024-04-28 12:10:18
28	3	132	5.60	5.60	f	2024-04-28 12:10:19	2024-04-28 12:10:19
29	3	132	4.60	4.60	f	2024-04-28 12:10:19	2024-04-28 12:10:19
30	3	132	3.60	3.60	f	2024-04-28 12:10:20	2024-04-28 12:10:20
31	3	132	2.60	2.60	f	2024-04-28 12:10:21	2024-04-28 12:10:21
32	3	132	1.60	1.60	f	2024-04-28 12:10:21	2024-04-28 12:10:21
33	3	132	0.60	0.60	f	2024-04-28 12:10:22	2024-04-28 12:10:22
34	3	132	49.60	49.60	f	2024-04-28 12:10:55	2024-04-28 12:10:55
35	3	132	48.60	48.60	f	2024-04-28 12:10:56	2024-04-28 12:10:56
36	3	132	47.60	47.60	f	2024-04-28 12:10:56	2024-04-28 12:10:56
37	3	132	46.60	46.60	f	2024-04-28 12:10:57	2024-04-28 12:10:57
38	3	132	45.60	45.60	f	2024-04-28 12:10:57	2024-04-28 12:10:57
39	3	132	44.60	44.60	f	2024-04-28 12:10:58	2024-04-28 12:10:58
40	3	132	43.60	43.60	f	2024-04-28 12:10:58	2024-04-28 12:10:58
41	3	132	42.60	42.60	f	2024-04-28 12:10:59	2024-04-28 12:10:59
42	3	132	41.60	41.60	f	2024-04-28 12:10:59	2024-04-28 12:10:59
44	3	132	39.60	39.60	f	2024-04-28 12:11:00	2024-04-28 12:11:00
43	3	132	40.60	40.60	t	2024-04-28 12:11:00	2024-04-28 12:11:09
45	3	132	38.60	38.60	f	2024-04-28 13:10:12	2024-04-28 13:10:12
6	5	132	48.00	48.00	f	2024-04-28 12:01:54	2024-04-28 13:12:29
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
admin@gmail.com	$2y$12$8Q7D34Q8/0ZEZ7Wkco5C6eZ1QRMKiDcS7hqW4.iCr4AnPX6TmQ2z2	2024-04-28 08:38:31
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
1	App\\Models\\User	1	api	6d8b896588d82f90cd21d442287838e713aa03e6fc1cbc44a3cb9d1038e86948	["*"]	\N	\N	2024-04-27 08:55:41	2024-04-27 08:55:41
3	App\\Models\\User	1	api	176cc004443a9fa6cc23bd52995400da14414c2b08ed6464932fd0a2b2a2207f	["*"]	\N	\N	2024-04-27 09:03:47	2024-04-27 09:03:47
4	App\\Models\\User	3	api	d77b14c220d9f8ccb72ebd2949b52c14c801d1e645ed83026da9468306899c7c	["*"]	2024-04-28 13:30:46	\N	2024-04-28 10:11:56	2024-04-28 13:30:46
2	App\\Models\\User	1	api	9e2d00aa123e9667af92e38f2210185dfa705ad2567ebe8fb7a5982069c54260	["*"]	2024-04-27 15:02:27	\N	2024-04-27 08:57:36	2024-04-27 15:02:27
5	App\\Models\\User	3	api	6f6c623180eeceeee72f3c8ab1869dd9126c35fab9741f90919b337520f0faaa	["*"]	\N	\N	2024-04-28 12:25:05	2024-04-28 12:25:05
7	App\\Models\\User	3	api	e97beb5b7514482e40443024a85a6276fc5350a51669951481bdbe9fa0d0db60	["*"]	\N	\N	2024-04-28 12:53:15	2024-04-28 12:53:15
6	App\\Models\\User	3	api	57357f12f59abb8732c13afdad1c07ea3e12cd2a43cff24d0d994378fb5d8806	["*"]	2024-04-28 13:08:35	\N	2024-04-28 12:27:06	2024-04-28 13:08:35
\.


--
-- Data for Name: points; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.points (id, user_id, points, created_at, updated_at) FROM stdin;
2	5	38.00	2024-04-28 11:49:04	2024-04-28 12:09:16
1	3	37.60	2024-04-28 10:41:33	2024-04-28 13:20:16
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
vsUy3Xk38gn0SSYx81vX71uskPTVkcEsPma8EjrT	3	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	YTo2OntzOjY6Il90b2tlbiI7czo0MDoiVnVkNFVkQlVYMzdibFhQSWpPMDVBc0NpclJFVVdNN2wySlpHVVIzSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9saXN0LW9mLWJ1eSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTozO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkNEhBVVhRM1lNMHNPOVVqRVRWRDNmZVZsSXFWU1R6UWxGWDFlaEtZSlF3WTljU24yekV1M0ciO30=	1714306270
UJ3JgKrn1DxBMBBtZuP6ExOwTbtn8Ou26wC2LL97	3	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36	YTo0OntzOjY6Il90b2tlbiI7czo0MDoicnQ0dFA1NjhiTUw2MHpNRjJyVGFiVGhmWjZBZTdpRkhNa1dVZ0dpYyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJDRIQVVYUTNZTTBzTzlVakVUVkQzZmVWbElxVlNUelFsRlgxZWhLWUpRd1k5Y1NuMnpFdTNHIjt9	1714311814
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, slug, name, created_at, updated_at) FROM stdin;
19	science	science	2024-04-27 15:52:31	2024-04-27 15:52:31
20	essay	essay	2024-04-27 15:52:31	2024-04-27 15:52:31
21	travel	travel	2024-04-27 15:52:31	2024-04-27 15:52:31
22	medical	medical	2024-04-27 15:52:31	2024-04-27 15:52:31
23	sports	sports	2024-04-27 15:52:31	2024-04-27 15:52:31
24	fiction	fiction	2024-04-27 15:52:31	2024-04-27 15:52:31
25	non-fiction	non-fiction	2024-04-27 15:52:31	2024-04-27 15:52:31
26	history	history	2024-04-27 15:52:31	2024-04-27 15:52:31
27	comics	comics	2024-04-27 15:52:31	2024-04-27 15:52:31
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
4	test	test@gmail.com	\N	$2y$12$PgufWjvmTD.jfsv/HEflGueKvSAyNCIuIyUk0tNnglYcZLpWI5lP6	\N	2024-04-28 08:39:13	2024-04-28 08:39:13
5	test 1	test1@gmail.com	\N	$2y$12$wHqkEU.RaH7xIttCu.20Neo1y83i7YfOTLXegWdhOcKmXlo8J1oI6	\N	2024-04-28 11:49:04	2024-04-28 11:49:04
3	User 1	admin@gmail.com	\N	$2y$12$4HAUXQ3YM0sO9UjETVD3feVlIqVSTzQlFX1ehKYJQwY9cSn2zEu3G	\N	2024-04-28 07:49:58	2024-04-28 12:11:41
\.


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 228, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 15, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 46, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 7, true);


--
-- Name: points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.points_id_seq', 2, true);


--
-- Name: tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_id_seq', 27, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: books_tags books_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_tags
    ADD CONSTRAINT books_tags_pkey PRIMARY KEY (books_id, tags_id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: points points_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.points
    ADD CONSTRAINT points_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tags tags_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_name_unique UNIQUE (name);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tags tags_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_slug_unique UNIQUE (slug);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: books_tags books_tags_books_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_tags
    ADD CONSTRAINT books_tags_books_id_foreign FOREIGN KEY (books_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: books_tags books_tags_tags_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books_tags
    ADD CONSTRAINT books_tags_tags_id_foreign FOREIGN KEY (tags_id) REFERENCES public.tags(id) ON DELETE CASCADE;


--
-- Name: orders orders_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: points points_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.points
    ADD CONSTRAINT points_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

