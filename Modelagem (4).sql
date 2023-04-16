-- CRIANDO SCHEMA

DROP SCHEMA IF EXISTS "EsquemaRH" CASCADE;

CREATE SCHEMA IF NOT EXISTS "EsquemaRH";

-- --------------------------------------

-- CRIANDO TABELAS 

CREATE  TABLE "EsquemaRH"."Cargo" ( 
  id_cargo             integer  NOT NULL  ,
  nome                 varchar(50)    ,
  descricao            varchar(500)    ,
  salario              decimal(10,2)    ,
  CONSTRAINT pk_cargo PRIMARY KEY ( id_cargo )
 );

CREATE  TABLE "EsquemaRH"."Categoria_Quarto" ( 
  id_categoria         varchar(2)  NOT NULL  ,
  descricao            varchar(500)    ,
  capacidade_max       integer  NOT NULL  ,
  permite_fumar        boolean  NOT NULL  ,
  permite_pets         boolean  NOT NULL  ,
  preco                decimal(10)  NOT NULL  ,
  CONSTRAINT pk_categoria_quarto PRIMARY KEY ( id_categoria )
 );

CREATE  TABLE "EsquemaRH"."Categoria_Servico" ( 
  id_categoria        integer  NOT NULL  ,
  nome                 varchar(50)    ,
  descricao            varchar(500)    ,
  CONSTRAINT pk_categoria_servico PRIMARY KEY ( id_categoria )
 );

CREATE  TABLE "EsquemaRH"."Departamento" ( 
  id_departamento      integer NOT NULL  ,
  nome                 varchar(50)    ,
  descricao            varchar(500)    ,
  endereco_cep                  varchar(20)    ,
  telefone             varchar(20)    ,
  CONSTRAINT pk_departamento PRIMARY KEY ( id_departamento )
 );

CREATE  TABLE "EsquemaRH"."Funcionario" ( 
  id_funcionario       integer  NOT NULL  ,
  nome                 varchar(100)    ,
  email                varchar(100)    ,
  telefone             varchar(20)    ,
  endereco_cep         varchar(20)    ,
  data_nascimento      date  NOT NULL  ,
  id_departamento      integer  NOT NULL  ,
  id_cargo             integer  NOT NULL  ,
  is_hotel             boolean  NOT NULL  ,
  CONSTRAINT pk_funcionario PRIMARY KEY ( id_funcionario ),
  CONSTRAINT fk_funcionario_departamento FOREIGN KEY ( id_departamento ) REFERENCES "EsquemaRH"."Departamento"( id_departamento )   ,
  CONSTRAINT fk_funcionario_cargo FOREIGN KEY ( id_cargo ) REFERENCES "EsquemaRH"."Cargo"( id_cargo )   
 );

CREATE  TABLE "EsquemaRH"."Hospede" ( 
  id_hospede           integer  NOT NULL  ,
  nome                 varchar(100)  NOT NULL  ,
  email                varchar(100)  NOT NULL  ,
  telefone             varchar(20)    ,
  endereco_cep         varchar(20)    ,
  data_nascimento           date NOT NULL  ,
  CONSTRAINT pk_hospede PRIMARY KEY ( id_hospede )
 );

CREATE  TABLE "EsquemaRH"."Hotel" ( 
  id_hotel             integer NOT NULL  ,
  nome                 varchar(100)    ,
  endereco             varchar(200)    ,
  telefone             varchar(20)    ,
  classificacao        integer,
  num_quartos          integer  NOT NULL  ,
  id_departamento      integer  NOT NULL  ,
  CONSTRAINT pk_hotel PRIMARY KEY ( id_hotel ),
  CONSTRAINT fk_hotel_hotel FOREIGN KEY ( id_departamento ) REFERENCES "EsquemaRH"."Departamento"( id_departamento )   
 );
 
CREATE  TABLE "EsquemaRH"."Quarto" ( 
  numero               integer  NOT NULL  ,
  status               varchar(50)  NOT NULL  ,
  id_hotel             integer  NOT NULL  ,
  id_categoria         varchar(2)  NOT NULL  ,
  CONSTRAINT pk_quarto PRIMARY KEY ( numero, id_hotel ),
  CONSTRAINT "fk_Quarto Hotel" FOREIGN KEY ( id_hotel ) REFERENCES "EsquemaRH"."Hotel"( id_hotel )   ,
  CONSTRAINT id_categoria FOREIGN KEY ( id_categoria ) REFERENCES "EsquemaRH"."Categoria_Quarto"( id_categoria )   
 );

CREATE  TABLE "EsquemaRH"."Reserva" ( 
  data_checkin         date  NOT NULL  ,
  data_checkout        date  NOT NULL  ,
  valor_total          decimal(10,2)  NOT NULL  ,
  id_hospede           integer  NOT NULL  ,
  id_hotel             integer  NOT NULL  ,
  numero               integer  NOT NULL  ,
  CONSTRAINT pk_reserva PRIMARY KEY ( data_checkin, id_hotel, numero ),
  CONSTRAINT "fk_Reserva Hospede" FOREIGN KEY ( id_hospede ) REFERENCES "EsquemaRH"."Hospede"( id_hospede )   ,
  CONSTRAINT fk_reserva_reserva FOREIGN KEY ( id_hotel, numero ) REFERENCES "EsquemaRH"."Quarto"( id_hotel, numero )   
 );
 
 INSERT INTO "EsquemaRH"."Funcionario" (id_funcionario, nome, email, telefone, endereco_cep, data_nascimento, id_departamento, id_cargo, is_hotel)
VALUES
(1, 'João Silva', 'joao.silva@email.com', '11 99999-8888', '04567-890', '1990-01-01', 1, 1, true),
(2, 'Maria Santos', 'maria.santos@email.com', '11 99999-7777', '01234-567', '1995-01-01', 2, 2, true),
(3, 'Lucas Souza', 'lucas.souza@email.com', '11 99999-6666', '05678-901', '2000-01-01', 3, 3, false),
(4, 'Julia Mendes', 'julia.mendes@email.com', '11 99999-5555', '04567-890', '1992-01-01', 4, 4, false),
(5, 'Pedro Costa', 'pedro.costa@email.com', '11 99999-4444', '01234-567', '1988-01-01', 5, 5, true);

INSERT INTO "EsquemaRH"."Hospede" (id_hospede, nome, email, telefone, endereco_cep, data_nascimento)
VALUES
(1, 'Maria', 'maria@gmail.com', '(11)1111-1111', '01001-000', '2000-04-03'),
(2, 'João', 'joao@hotmail.com', '(21)2222-2222', '02002-000', '1987-02-07'),
(3, 'Ana', 'ana@yahoo.com.br', '(31)3333-3333', '03003-000', '1999-09-30'),
(4, 'Pedro', 'pedro@gmail.com', '(41)4444-4444', '04004-000', '1976-10-23'),
(5, 'Lucas', 'lucas@hotmail.com', '(51)5555-5555', '05005-000', '1963-09-16');

INSERT INTO "EsquemaRH"."Hotel" ("id_hotel", "nome", "endereco", "telefone", "classificacao", "num_quartos", "id_departamento") VALUES
(1, 'Grand Hotel', 'Av. Paulista, 1000, São Paulo', '(11) 1111-1111', 2, 200, 1),
(2, 'Hotel Copacabana Palace', 'Av. Atlântica, 1702, Rio de Janeiro', '(21) 2222-2222', 3, 300, 2),
(3, 'Hotel Fasano', 'Rua Vitório Fasano, 88, São Paulo', '(11) 3333-3333', 6, 100, 3),
(4, 'Hotel Unique', 'Av. Brigadeiro Luís Antônio, 4700, São Paulo', '(11) 4444-4444', 5, 120, 4),
(5, 'Hotel Windsor Barra', 'Av. Lucio Costa, 2630, Rio de Janeiro', '(21) 5555-5555', 4, 150, 2);

INSERT INTO "EsquemaRH"."Quarto" ("numero", "status", "id_hotel", "id_categoria") VALUES
(101, 'Disponível', 1, 'ST'),
(102, 'Disponível', 1, 'ST'),
(103, 'Disponível', 1, 'LD'),
(201, 'Disponível', 2, 'LS'),
(202, 'Disponível', 2, 'SP');

INSERT INTO "EsquemaRH"."Reserva" (data_checkin, data_checkout, valor_total, id_hospede, id_hotel, numero) VALUES
('2023-04-01', '2023-04-03', 500.00, 1, 1, 101),
('2023-05-15', '2023-05-20', 1200.00, 2, 1, 102),
('2023-07-01', '2023-07-05', 800.00, 3, 1, 103),
('2023-06-10', '2023-06-12', 350.00, 4, 2, 201),
('2023-08-20', '2023-08-27', 1600.00, 5, 2, 202);

INSERT INTO "EsquemaRH"."Servico" (id_servico, data_inicio, data_fim, preco, id_categoria, id_hotel, id_departamento)
VALUES 
(1, '2023-04-01', '2023-04-01', 50.00, 1, 1, 1),
(2, '2023-05-15', '2023-05-19', 80.00, 2, 2, 2),
(3, '2023-07-01', '2023-07-03', 30.00, 3, 3, 3),
(4, '2023-06-10', '2023-06-11', 25.00, 4, 4, 4),
(5, '2023-08-20', '2023-08-25', 120.00, 5, 5, 5);

INSERT INTO "EsquemaRH"."Avaliacao" (id_hospede, id_hotel, data_avaliacao, nota_atendimento, nota_limpeza, nota_conforto, nota_localizacao, nota_custobeneficio, comentario)
VALUES (1, 1, '2022-05-01', 4, 5, 3, 4, 3, 'Gostei muito da minha estadia, mas achei o quarto um pouco apertado.'),
(2, 2, '2022-03-15', 5, 5, 5, 5, 5, 'O atendimento foi excepcional! Recomendo para todos!'),
(3, 1, '2022-01-30', 3, 4, 3, 4, 3, 'Hotel ok para uma viagem de negócios.'),
(4, 3, '2022-06-20', 4, 4, 4, 5, 4, 'Ótimo hotel, mas poderia ter mais opções de café da manhã.'),
(5, 2, '2022-04-10', 4, 4, 4, 4, 4, 'Bom hotel, mas o chuveiro demorava muito para esquentar.');

INSERT INTO "EsquemaRH"."Trabalhador_Hotel" (id_funcionario, id_hotel, avaliacao_local, horario_entrada, horario_saida)
VALUES (1, 1, 4, '08:00', '17:00'),
(2, 1, 3, '13:00', '22:00'),
(3, 2, 5, '09:00', '18:00'),
(4, 3, 4, '07:00', '16:00'),
(5, 2, 4, '14:00', '23:00');