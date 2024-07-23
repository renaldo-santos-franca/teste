--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-1.pgdg22.04+1)

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

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_superior;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT fk_funcionario;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: renaldodsf
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome character varying(100) NOT NULL,
    funcao character varying(15) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT check_funcao_superior CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL)))),
    CONSTRAINT ck_cpf_length CHECK ((length(cpf) = 11)),
    CONSTRAINT funcionario_funcao_check CHECK (((funcao)::text = ANY ((ARRAY['LIMPEZA'::character varying, 'SUP_LIMPEZA'::character varying])::text[]))),
    CONSTRAINT funcionario_nivel_check CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.funcionario OWNER TO renaldodsf;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: renaldodsf
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT check_func_resp_cpf_status CHECK (((status = 'P'::bpchar) OR (func_resp_cpf IS NOT NULL))),
    CONSTRAINT ck_prioridade_intervalo CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT ck_status CHECK ((status = ANY (ARRAY['P'::bpchar, 'E'::bpchar, 'C'::bpchar]))),
    CONSTRAINT func_resp_cpf_length CHECK ((length(func_resp_cpf) = 11))
);


ALTER TABLE public.tarefas OWNER TO renaldodsf;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: renaldodsf
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678920', '1990-01-01', 'Ana Costa', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678921', '1992-02-02', 'Carlos Silva', 'LIMPEZA', 'J', '12345678920');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678922', '1985-03-03', 'Maria Oliveira', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678923', '1991-04-04', 'João Santos', 'LIMPEZA', 'P', '12345678922');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678924', '1988-05-05', 'Lucia Almeida', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678925', '1993-06-06', 'Pedro Lima', 'LIMPEZA', 'J', '12345678924');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678926', '1984-07-07', 'Claudia Ferreira', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678927', '1995-08-08', 'Roberto Silva', 'LIMPEZA', 'S', '12345678926');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678928', '1983-09-09', 'Fernanda Costa', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678929', '1994-10-10', 'André Santos', 'LIMPEZA', 'J', '12345678928');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1980-05-07', 'Pedro', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1980-03-08', 'Jose', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1980-03-08', 'Jose', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1980-03-08', 'Jose Pedro', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678950', '1980-01-01', 'Funcionario 1', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678951', '1981-02-02', 'Funcionario 2', 'LIMPEZA', 'J', '12345678950');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: renaldodsf
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (1, 'Tarefa 1', NULL, 1, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2, 'Tarefa 2', '12345678950', 2, 'E');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (3, 'Tarefa 3', '12345678951', 3, 'C');


--
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: renaldodsf
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: renaldodsf
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- Name: tarefas fk_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: renaldodsf
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_funcionario FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: funcionario fk_superior; Type: FK CONSTRAINT; Schema: public; Owner: renaldodsf
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_superior FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

