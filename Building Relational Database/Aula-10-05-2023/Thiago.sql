/*#######################Tabelas de Python########################*/
                        /*Exemplo BD*/
create table aluno 
(aluno_id number generated always as identity primary key,
aluno_ra number,
aluno_nome varchar2(50),
aluno_curso varchar2(30),
aluno_idade int);

select * from aluno



/*Tarefa 01*/

create table clientes
(cliente_id number generated always as identity primary key,
cliente_nome varchar(50),
cliente_logradouro varchar(70),
cliente_bairro varchar(40),
cliente_cidade varchar(50),
cliente_idade varchar(50),
cliente_lmt_credito float);

select * from clientes

SELECT * FROM clientes 
WHERE cliente_idade > 35 AND cliente_cidade = 'São Paulo'

select * from clientes where cliente_cidade = 'Rio de Janeiro' and 
cliente_lmt_credito > 5000

desc clientes



/*Tarefa 02*/

create table produtos
(produto_id number generated always as identity primary key,
produto_desc varchar(50),
produto_categ varchar(30),
produto_quant_estoq number,
produto_vlr_compra float,
produto_vlr_venda float
);

select * from produtos

select * from clientes where cliente_cidade = 'Rio de Janeiro' and 
cliente_lmt_credito > 5000

select * from produtos where produto_quant_estoq < 100

select * from produtos where produto_quant_estoq > 120 and 
produto_vlr_venda between 121 and 350 order by 1



desc produtos











/*###########################Banco de Dados#########################*/
                             /* Aula 01 */

Introdução a linguagem SQL
DDL - Linguagem de definição de dados - Estrutura
Criando tabelas
Sintaxe:
    create table nome_tabela
    (nome_coluna1 tipo_dados(tamanho) [regra],
    ......,
    nome_colunaN tipo_dados(tamanho) [regra]);
    
Tipo de dados: char(n), campo alfanumérico de tamanho fixo
               varchar(n), campo alfanumérico de tamanho variavel
               number(x,y), campo numérico inteiro ou real
               date, campo tipo data
n = tamanho
x = parte inteira
y = parte real, casas decimais

Regras/Constraints
Pk - primary key, campo unico, preenchimento obrigatório, relacionamento
FK - foreign key, relacionamento lado n da cardinalidade, recebe dados
     previamente cadastrados na Pk
Nn - not null, campo de preenchimento obrigatorio
Uk - unique, campo com restriçao a dados repetidos
Ck - check, campo com lista de dados para validação

Exemplificando

1- criando uma tabela sem regras:

create table cargo10
(cd_cargo number(3),
nm_cargo varchar2(25),
salario number(8,2));

visualizando a estrutura de uma tabela
desc nome_tabela
exemplo: desc cargo10

deletando uma tabela
drop table nome_tabela
exemplo: drop table cargo10

2- criando uma tabela com regras, sem personalização:
create table cargo10
(cd_cargo number(3) primary key,
nm_cargo varchar2(25)not null unique,
salario number(8,2));

desc cargo10

visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO10'

2- criando uma tabela com regras, com personalização:

drop table cargo10

create table cargo10
(cd_cargo number(3) constraint cargo_cd_pk primary key,
nm_cargo varchar2(25)constraint cargo_nome_nn not null 
                     constraint cargo_nome_uk unique,
salario number(8,2));

desc cargo10

visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO10'

criando o relacionamento

1 - 1 - Pk + FK_Uk
1 - N - Pk + FK
N - N - não existe em código sql

desc cargo10
create table funcionario10
(cd_fun number(3) constraint fun_cd_pk primary key,
nm_fun varchar(30) constraint fun_nm_nn not null,
dt_adm date constraint fun_dt_nn not null,
uf_fun char(2) constraint fun_uf_nn not null,
cargo_fk number(3) constraint fun_cargo_fk references cargo)

desc funcionario10

create table funcionario11
(cd_fun number(3) constraint fun_cd_pk1 primary key,
nm_fun varchar(30) constraint fun_nm_nn1 not null,
dt_adm date constraint fun_dt_nn1 not null,
uf_fun char(2) constraint fun_uf_nn1 not null,
cargo_fk references cargo)

Criação das tabelas: n_fiscal e produto















/* Aula 02*/
15/02/2023

create table n_fiscal
(n_nf number(5) primary key,
dt_nf date not null,
total_nf number(10,2));

desc n_fiscal
select constraint_name from user_constraints where table_name = 'N_FISCAL'

desc n_fiscal

create table produto
(cd_pro number(5) constraint prod_cd_pk primary key,
nm_prod varchar2(30) constraint prod_mn_nn not null
constraint prod_nm_uk unique,
preco number(10,2))

select constraint_name from user_constraints where table_name = 'PRODUTO'

create table tem
(fk_nota number(5) constraint tem_nf_fk references n_fiscal,
fk_prod number(5) constraint tem_prod_fk references produto)

Inserindo dados
Comando DML - Data Manipulation Language
Novas linhas:
insert into nome_tabela values
(valor1, valor2,...., valorN)

Obs: campos: char, varchar ou varchar2 e date precisam de apóstrofe

Exemplo 1
conhecendo ou visualizando a estrutura
desc n_fiscal
inserindo uma linha
insert into n_fiscal values (1,'10-Jan-00',5000);
insert into n_fiscal values (2,'10-dec-00',5000);
verificando a inserção
select * from n_fiscal
descobrindo o padrão da data
select sysdate from dual
gravando dados fisicamente
commit;


























/*Aula 03 - 01/03/2023*/

Ainda trabalhando com estrutura das tabelas

DDL
Create - Ok

Alterando ou corrigindo uma estrutura
alter table nome_tabela
opções
add column      - nova coluna
add constraint  - nova regra
modify          - modifica tipo e/ou tamanho de uma coluna
drop column     - elimina uma coluna
drop constraint - elimina uma regra

create table tb_teste
(codigo number(2),
nome number(10));

incluindo uma nova coluna
alter table tb_teste add dt_nasc date
incluindo uma coluna com regra
alter table tb_teste add cep char(8) not null
incluindo a pk na coluna codigo
alter table tb_teste add constraint pk_cod primary key (codigo)
modificando apenas o tipo de dados
alter table tb_teste modify nome varchar(10)
modificando apenas o tamanho da coluna
alter table tb_teste modify nome varchar(50)
modificando tamanho e tipo ao mesmo tempo
alter table tb_teste modify nome number(10)
eliminando uma regra
alter table tb_teste drop constraint pk_cod
desc tb_teste
desc user_constraints
select constraint_name from user_constraints where table_name = 'TB_TESTE'
eliminando uma coluna
alter table tb_teste drop column nome
desc tb_teste
renomeando uma coluna
alter table tb_teste rename column codigo to cod_cliente
renomeando uma constraint
alter table tb_teste rename constraint sys_c003509437 to fiap
eliminando uma tabela
drop table nome_tabela
drop table tb_teste

create table tb_teste1
(codigo number(1) primary key)
create table tb_teste2
(codigo number(1) references tb_teste1)
insert into tb_teste1 values(1)
insert into tb_teste2 values(1)
drop table tb_teste1 cascade constraints
uso do cascade permite eliminar o relacionamento e depois dropar a tabela





























/*Aula 04*/ 

Update 

operadores: aritméticos: + - * / ()
            relacionais: > >= < <= = != ou <>
            lógicos: and or not
            
update nome_tabela set nome_coluna = novo_valor

update nome_tabela set nome_coluna = novo_valor
where condição

create table produto_tb 
(cod_prod number(4) constraint prod_cod_pk primary key, 
unidade varchar2(3),descricao varchar2(20),val_unit number(10,2))

insert into produto_tb values ('25','KG','Queijo','0.97');
insert into produto_tb values ('31','BAR','Chocolate','0.87');
insert into produto_tb values ('78','L','Vinho','2.00');
insert into produto_tb values ('22','M','Linho','0.11');
insert into produto_tb values ('30','SAC','Acucar','0.30');
insert into produto_tb values ('53','M','Linha','1.80');
insert into produto_tb values ('13','G','Ouro','6.18');
insert into produto_tb values ('45','M','Madeira','0.25');
insert into produto_tb values ('87','M','Cano','1.97');
insert into produto_tb values ('77','M','Papel','1.05');
commit;

select * from produto_tb

-atualizando os dados do preço do produto para R$1,00
update produto_tb set val_unit = 1

-atualizando os dados do preço do produto para R$1,5
apenas dos produtos de unidade de medida igual a metro
update produto_tb set val_unit = 1.5
where unidade = 'M'
select * from produto_tb order by 1

-atualizar em 15% o preço dos produtos de código maior que 30.
update produto_tb set val_unit = val_unit * 1.15
where cod_prod > 30

-atualizar o nome do produto queijo para queijo de minas.
update produto_tb set descricao = 'Queijo De Minas'
where descricao = 'Queijo'

-para os produtos Açucar, madeira e Linha zerar o seu preço.
update produto_tb set val_unit = 0
where descricao = 'Acucar' or descricao = 'Linha'
or descricao = 'Madeira'

select * from produto_tb4

desc produto_tb
























/*Aula 4 - 08/03/23 - finalizando DML*/

Eliminando linha(s)
todas
delete from nome_tabela
algumas
delete from nome_tabela where condição

commit

Apagando tudo
select * from produto_tb

delete from produto_tb

rollback

delete from produto_tb where cod_prod = 31

Gravando os dados em disco: commit

Desfazendo DML: rollback

Atenção: uma vez executado o commit, o rollback não funciona



























/*Aula 5 - 15/03/2023 - resolvendo os exercício*/

Ckp 01 - 29/03/2023

create table cidade
(codigo number(4) constraint pk_cd_cid primary key,
nome varchar(30) constraint nn_nome_cid not null)

create table socio
(cpf char(11) constraint pk_cpf_soc primary key,
nome varchar(20) constraint nn_nome_soc not null,
datanasc date constraint nn_dt_soc not null,
rg varchar(15) constraint nn_rg_soc not null,
cidade number(4) constraint nn_cid_soc not null
constraint fk_cid_soc references cidade)

alter table cidade add uf char(2) constraint nn_uf_cid not null

alter table socio add (fone varchar(10),
sexo char(1) constraint nn_sx_soc not null)

alter table socio modify nome varchar(35)

create table setor (codigo number(3) primary key,
nome varchar(30) not null)

alter table socio add setor number(3) not null references setor

create table dependente (socio char(11) not null references socio,
numero number(4) primary key,
nome varchar(30) not null,
datanasc date not null)

desc cidade - exibir a estrutura da tabela
insert into cidade values(1,'São Paulo', 'SP');
insert into cidade values(2,'Parati', 'RJ');
commit;
desc setor
insert into setor values (10,'Administrativo');
insert into setor values (20,'Contabil');
commit;
desc socio
insert into socio values ('1111111111', 'Joana', '12-nov-1999',
'111111111111111', 1, '1111111111', 'F', 10);
insert into socio values ('2111111111', 'Marcos', '16-feb-02',
'211111111111111', 2, '2111111111', 'F', 20);
commit;
desc dependente
insert into dependente values ('1111111111', 100, 'Guilherme', '11-nov-11');
insert into dependente values ('2111111111', 101, 'Rosana', '04-feb-1995');
commit;

select * from cidade
select * from socio
select * from setor
select * from dependente


























/*Aula 06 - Gabarito Empregados*/

drop table empregado cascade constraints;

create table Empregado
(Nome_Empregado Varchar(50)not null,
Rua Varchar(100) not null,
Cidade Varchar(30),
Estado_Civil Varchar(15));

alter table empregado add salario number(11,2);

alter table empregado add data_nascimento date;

alter table empregado modify cidade varchar(110);

drop table companhia cascade constraints;

create table Companhia
(Nome_Companhia Varchar(50) primary key,
Cidade Varchar(30));

alter table empregado add primary key (nome_empregado);

drop table trabalha cascade constraints;
create table Trabalha
(Nome_Empregado Varchar(50)primary key references empregado,
Nome_Companhia Varchar(50)not null references companhia,
Salário Number(9,2) not null);
drop table gerente cascade constraints;

create table Gerente
(Nome_Empregado Varchar(50)not null references empregado,
Nome_Gerente Varchar(50)not null references empregado);



Gabarito - Locadora

Estrutura
drop table categoria cascade constraints;
create table CATEGORIA
(Codcateg number(4) primary key,
Descricao varchar(50) not null);

drop table filme cascade constraints;
create table Filme
(CodFilme number(4)primary key,
Titulo varchar(70)not null,
codcat references categoria);

drop table dvd cascade constraints;
create table DVD 
(NumDVD number(4)primary key,
codfilme references filme,
Tipo char(1));

drop table cliente cascade constraints;
create table Cliente 
(CodCli number(4)primary key,
Prenome varchar(50) not null,
Sobrenome varchar(50), Endereco varchar(70), Telefone varchar(20));

drop table aluga cascade constraints;
create table aluga 
(cd_clie references cliente,
cd_dvd references dvd,
data_ret date, data_dev date,
num_aluga number(4) primary key);

drop table ator cascade constraints;
create table Ator 
(Codator number(4) primary key,
Nome_popular varchar(50)not null,
Nome_artistico varchar(50),
Datanasc date);

drop table estrela cascade constraints;
create table estrela 
(cod_ator references ator,
cod_filme references filme);

Dados:

insert into categoria values (1,'Comédia');
insert into categoria values (2,'Drama');
insert into categoria values (3,'Aventura');
insert into categoria values (4,'Terror');
commit;
insert into filme values (1,'Sai pra lá',1);
insert into filme values (2,'Ajuda Eterna',2);
insert into filme values (3,'Anjos Malditos',2);
insert into filme values (4,'Pânico II',4);
insert into filme values (5,'Um dia de furia',3);
insert into filme values (6,'Lente Cega',3);
insert into filme values (7,'Sinais do Tempo',2);
insert into filme values (8,'A melodia da vida',1);
commit;
insert into dvd values (1,1,'S');
insert into dvd values (2,1,'S');
insert into dvd values (3,1,'S');
insert into dvd values (4,2,'D');
insert into dvd values (5,3,'S');
commit;
insert into cliente values (1,'João','Silva','Rua da Cruz sem Pé','4444-1111');
insert into cliente values (2,'Antônio','Ferreira','Av. da Vila Velha','6660-9333');
insert into cliente values (3,'Fabio','Dias','Rua Antonio Vieira','2337-0393');
insert into cliente values (4,'Andreia','Melo','Rua da Praia Bonita','8989-7777');
insert into cliente values (5,'Murilo','Fontes','Av. dos Autonomistas','9090-9090');
commit;

Altere o número da categoria Comédia de 01 para 08 na tabela CATEGORIA.
Esta alteração não pode ser realizada diretamente na PK, pois existem dados
na FK que são os mesmos da PK.
Passo 1: realizar a troca dos dados da fk para null
desc filme
select * from filme
update filme set codcat = null where codcat = 1;
Passo 2: trocar o valor da PK de 1 para 8
desc categoria
select * from categoria
update categoria set codcateg = 8 where codcateg = 1;
Passo 3: atualiza as fks nulas para 8
update filme set codcat = 8 where codcat is null;
commit;

Insira a coluna SINOPSE na tabela FILME com 300 caracteres.
alter table filme add sinopse varchar(300);

Cadastre uma nova categoria de filme chamada FICÇÃO.
insert into categoria values (5, 'Ficção');

Apague o filme chamado “Anjos Malditos” e “A melodia da vida” 
da tabela FILME. Para isso, utilize um único comando. 


























/*Aula 7 - 12/04/2023 */
Nosso sistema

drop table cliente cascade constraints;
drop table vendedor cascade constraints;
drop table pedido cascade constraints;
drop table item_pedido cascade constraints;
drop table produto cascade constraints;
/*Cascade exclui as relações ligadas as tabelas*/

create table cliente 
(cod_clie number(4) constraint clie_cd_pk primary key, 
nome_clie varchar2(20) constraint clie_no_nn not null, 
endereco varchar2(30),cidade varchar2(15), 
cep char(8),uf char(2),cnpj char(16),ie char(12));

create table vendedor 
(cod_ven number(4) constraint ven_cod_pk primary key, 
nome_ven varchar2(20) constraint ven_no_nn not null, 
salario_fixo number(12,2),comissao char(1));

create table produto 
(cod_prod number(4) constraint pro_cod_pk primary key, 
unidade varchar2(3),descricao varchar2(20),val_unit number(10,2));

create table pedido 
(num_pedido number(4) constraint pedido_num_pk primary key, 
pr_entrega number(3) constraint entrega_pr_nn not null, 
cod_clie references cliente,cod_ven references vendedor);

create table item_pedido 
(num_pedido references pedido, 
cod_prod references produto, 
quant number(10,2));

insert into cliente values(720,'Ana','Rua 17 n.19','Niteroi','24358310','RJ','12113231/0001-34','2134');

insert into cliente values(870,'Flavio','Av. Pres. Vargas, 10','Sao Paulo','22763931','SP','22534126/9387-9','4631');

insert into cliente values(110,'Jorge','Rua Caiapo, 13','Curitiba','30078500','PR','14512764/9834-9',null);

insert into cliente values(222,'Lucia','Rua Itabira, 123','Belo Horizonte','22124391','MG','283152123/9348-8','2985');

insert into cliente values(830,'Mauricio','Av. Paulista, 1236','Sao Paulo','3012683','SP','32816985/7465-6','9343');

insert into cliente values(130,'Edmar','Rua da Praia, s/n','Salvador','30079300','BA','23463284/234-9','7121');

insert into cliente values(410,'Rodolfo','Largo da Lapa, 27','Rio de Janeiro','30078900','RJ','12835128/2346-9','743');

insert into cliente values(20,'Beth','Av. Climerio, 45','Sao Paulo','25679300','SP','32485126/7326-8','9280');

insert into cliente values(157,'Paulo','Trav. Moraes, casa 3','Londrina',null,'PR','32848223/324-2','1923');

insert into cliente values(180,'Livio','Av. Beira Mar, 1256','Florianopolis','30077500','SC','12736571/2347-4','1111');

insert into cliente values(260,'Susana','Rua Lopes Mandes, 12','Niteroi','30046500','RJ','21763571/232-9','2530');

insert into cliente values(290,'Renato','Rua Meireles, 123','Sao Paulo','30225900','SP','13276571/1231-4','1820');

insert into cliente values(390,'Sebastiao','Rua da Igreja, 10','Uberaba','30438700','MG','32176547/213-3','9071');

insert into cliente values(234,'Jose','Quadra 3, Bl. 3, sl. 1003','Brasilia','22841650','DF','21763576/1232-3','2931');

commit;

insert into vendedor values(209,'Jose','1800','C');

insert into vendedor values(111,'Carlos','2490','A');

insert into vendedor values(11,'Joao','2780','C');

insert into vendedor values(240,'Antonio','9500','C');

insert into vendedor values(720,'Felipe','4600','A');

insert into vendedor values(213,'Jonas','2300','A');

insert into vendedor values(101,'Joao','2650','C');

insert into vendedor values(310,'Josias','870','B');

insert into vendedor values(250,'Mauricio','2930','B');

commit;

commit;

insert into produto values ('25','KG','Queijo','0.97');

insert into produto values ('31','BAR','Chocolate','0.87');

insert into produto values ('78','L','Vinho','2.00');

insert into produto values ('22','M','Linho','0.11');

insert into produto values ('30','SAC','Acucar','0.30');

insert into produto values ('53','M','Linha','1.80');

insert into produto values ('13','G','Ouro','6.18');

insert into produto values ('45','M','Madeira','0.25');

insert into produto values ('87','M','Cano','1.97');

insert into produto values ('77','M','Papel','1.05');

commit;

insert into pedido values ('121','20','410','209');

insert into pedido values ('97','20','720','101');

insert into pedido values ('101','15','720','101');

insert into pedido values ('137','20','720','720');

insert into pedido values ('148','20','720','101');

insert into pedido values ('189','15','870','213');

insert into pedido values ('104','30','110','101');

insert into pedido values ('203','30','830','250');

insert into pedido values ('98','20','410','209');

insert into pedido values ('143','30','20','11');

insert into pedido values ('105','30','180','240');

insert into pedido values ('111','15','260','240');

insert into pedido values ('103','20','260','11');

insert into pedido values ('91','20','260','11');

insert into pedido values ('138','20','260','11');

insert into pedido values ('108','15','290','310');

insert into pedido values ('119','30','390','250');

commit;

insert into item_pedido values ('121','25','10');

insert into item_pedido values ('121','31','35');

insert into item_pedido values ('97','77','20');

insert into item_pedido values ('101','31','9');

insert into item_pedido values ('101','78','18');

insert into item_pedido values ('101','13','5');

insert into item_pedido values ('98','77','5');

insert into item_pedido values ('148','45','8');

insert into item_pedido values ('148','31','7');

insert into item_pedido values ('148','77','3');

insert into item_pedido values ('148','25','10');

insert into item_pedido values ('148','78','30');

insert into item_pedido values ('104','53','32');

insert into item_pedido values ('203','31','6');

insert into item_pedido values ('189','78','45');

insert into item_pedido values ('143','31','20');

insert into item_pedido values ('143','78','10');

commit;







Construindo relatórios, comandos - DQL
Data Query Language

Exibindo o conteúdo de uma tabela, todas as linhas e colunas

Sintaxe básica: select * from nome_tabela;
Select = seleção
* = todas as colunas
from = origem dos dados
nome_tabela = tabela destino do relatório

Exemplos:

1) exibir o conteúdo da tabela cliente
select * from cliente;

1.1) mostre o conteúdo da tabela vendedor.
select * from vendedor;

1.2) mostre o conteúdo da tabela que possui os produtos e seus pedidos.
select * from item_pedido;





2) criando um relatório com colunas específicas
Sintaxe: Select nome_col1, nome_col2 from nome_tabela
nome_col = nome da coluna a ser exibida
Mostrar o nome do cliente e o estado onde ele mora
select nome_clie, uf from cliente;

2.1) exiba o nome do vendedor e seu salário
select nome_ven, salario_fixo from vendedor;

2.2) mostre o nome do produto e seu preço
select descricao, val_unit from produto;





3) classificando relatórios
Sitaxe: select * from tabela order by nome_col asc (default)- crescente
Sitaxe: select * from tabela order by nome_col desc - decrescente
select nome_clie, uf from cliente order by nome_clie asc (opcional)
select * from cliente order by 4 desc;
select nome_clie, uf from cliente order by 1 asc (opcional)
select nome_clie, uf from cliente order by 1 desc
select uf, nome_clie from cliente order by 1,2
select uf, nome_clie from cliente order by 1,2 desc

3.1) criar um relatório que mostre os pedidos organizados por número (crescente),
     cliente e vendedor decrescente
select * from pedido order by 1, 3 desc, 4 desc

3.2) mostrar em ordem decrescente de salário os dados dos vendedores
select * from vendedor order by 3 desc





4) apelidando colunas
Sintaxe: select nome_col Apelido, nome_col "apelido da coluna" from tabela
select nome_clie Cliente, endereco "Local da morada" from cliente
select nome_clie, endereco from cliente




5) usando filtro de linhas
Sintaxe: select * from tabela where nome_col operador valor
Operadores: aritméticos: + - * / ()
            relacionais : > >= < <= = <> ou !=
            lógicos: and or not
            BD: between, in, like
5.1) crie um relatório que mostre qual será o salário do vendedor com um aumento
     de 10%
select salario_fixo "sal atual", salario_fixo * 1.1 "Sal Reaj 10%" from vendedor;

5.2) crie um relatório que exiba os clientes com nome e uf que morem no estado
     de SP
5.3) quais produtos custam abaixo de R$1,50? mostre em ordem crescente de valor
     o preço e a descrição
5.4) Quais pedidos foram feitos pelos clientes de código maior que 500? Mostre o
     código do cliente e o número do pedido classifcado pelo código do cliente
     de forma crescente
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

/*Aula 8 - 19/04 - gabarito exercícios*/

LISTA DE UPPER
-UPPER(Letra maiúscula)
-LOWER(Letra minúscula)
-INITCAP(Primeira letra maiúscula)
-LENGTH(tamanho)
select nome_clie, upper(nome_clie), lower(nome_clie), initcap(nome_clie),
length(nome_clie) from cliente;

5.2) select nome_clie, uf  from cliente where upper(uf) = 'SP';
5.3) select descricao, val_unit from produto where val_unit < 1.5
     order by 2
5.4) select num_pedido, cod_clie from pedido where cod_clie > 500 order by 2
5.5) crie um relatório que exiba o código do cliente e seu nome, desde que
    estejam no intervalo de código com início em 180 até 720 (inclusive)
    select cod_clie, nome_clie from cliente
    where cod_clie >= 180 and cod_clie <= 720 order by 1
    
5.6)crie um relatório que exiba o código do cliente e seu nome, desde que
    estejam no intervalo de código com início em 180 até 720
    select cod_clie, nome_clie from cliente
    where cod_clie > 180 and cod_clie < 720 order by 1
    
5.7) crie um relatório que exiba o nome do cliente, desde que
    estejam no intervalo de B até F (inclusive)
    
    select nome_clie from cliente
    where upper(nome_clie) >= 'B' and upper(nome_clie) < 'G';
    
5.8) quem são os vendedores com salário superior a R$2.000,00, que pertençam a 
     comissão A ou C e que seu código esteja no intervalo de 500 até 800
     
     select * from vendedor where salario_fixo > 2000
     and lower(comissao) != 'b' and cod_ven > 500 and cod_ven < 800
     cuidado *****************************************************
     select * from vendedor where salario_fixo > 2000
     and (lower(comissao) = 'a' or lower(comissao) = 'c') 
     and cod_ven > 500 and cod_ven < 800

Operadores de BD:
    between (intervalo sequencial)-> coluna1 between valor inicial and valor final
    exemplo:
usando operador tradicional: select cod_clie, nome_clie from cliente
                 where cod_clie >= 180 and cod_clie <= 720 order by 1

usando operador bd: select cod_clie, nome_clie from cliente
           where cod_clie between 180 and 720 order by 1

usando o operador not: coluna1 not between valor inicial and valor final
        select cod_clie, nome_clie from cliente
        where cod_clie not between 180 and 720 order by 1
        
in(list) (igual a uma lista) -> coluna1 in(valor1,...., valorN)
exemplo: 
usando operador tradicional:
            select nome_clie, uf from cliente
            where uf = 'SP' or uf = 'RJ' or uf = 'MG' order by uf;
usando operador bd:
            select nome_clie, uf from cliente
            where uf in('SP','RJ','MG') order by uf;
usando o operador not: not in(list)
        select nome_clie, uf from cliente
            where uf not in('SP','RJ','MG') order by uf;
            
            
            
            
like - igual a posição ou igual a posições - > coluna like 'opção'
% = qualquer quantidade, qualquer posição
_ = posição e quantidade especifica





Nomes que tenham a letra 'a'
select nome_clie from cliente where upper(nome_clie) like '%A%';


Nomes com a letra 'o'
select nome_clie from cliente where upper(nome_clie) like '%O%';


Nomes que não iniciam com 'M' e 'R'
select nome_clie from cliente where upper(nome_clie) not like 'M%'


and upper(nome_clie) not like 'R%';
Nomes que a penúltima letra é a letra 'i'


select nome_clie from cliente where upper(nome_clie) like '%I_';
Nomes com as letras 'a' ou 's'


select nome_clie from cliente 
where upper(nome_clie) like '%A%' and upper(nome_clie) not like '%S%';


Nomes com as letras 'a' e 's'
select nome_clie from cliente 
where upper(nome_clie) like '%A%' and upper(nome_clie) like '%S%';



/* Aula 09 - 10/05 - Inner Join */
/* https://www.devmedia.com.br/sql-join-entenda-como-funciona-o-retorno-dos-dados/31006 */

create table cargo(
cd_cargo number(2) constraint cd_cargo_pk primary key,
nm_cargo varchar(20) constraint nm_cargo_nn not null,
salario number(8, 2));

create table funcionario(
id_fun number(2) constraint id_fun_pk primary key,
nm_fun varchar(20),
cargo_fk number(2) constraint cargo_fun_fk references cargo);

insert into cargo values (1, 'Prq. Web', 4500);
insert into cargo values (2, 'DBA', 12000);
insert into cargo values (3, 'Analista Dados', 8000);

insert into funcionario values (10, 'Marcel', 1);
insert into funcionario values (11, 'Claudio', 2);
insert into funcionario values (12, 'Amanda', 2);
insert into funcionario values (13, 'Samantha', null);

select * from cargo;
select * from funcionario;

/* Junção de tabelas - join

Usado qdo é necessário pesquisar dados em mais de uma tabela

Tipos de junção:

Inner Join - equivalência, igualdade

Criar um relatório que mostre o nome do funcionário e o nome do cargo que ele ocupa */

select nm_cargo, nm_fun from cargo inner join funcionario on cd_cargo = cargo_fk;

/* Left ou Right join - diferença mais igualdade entre tabelas
Criar um relatório que mostre o nome do funcionário, o nome do cargo que ele ocupa
e caso exista algum cargo não vinculado ao funcionário este deve ser exibido tb. */

select nm_cargo, nm_fun from cargo left join funcionarioon cd_cargo = cargo_fk;

select nm_cargo, nm_fun from cargo right join funcionarioon cd_cargo = cargo_fk;

/* Left ou Right join - diferença sem igualdade entre tabelas
perguntando tb se a fk está vazia - null */

select nm_cargo, nm_fun from cargo left join funcionario on cd_cargo = cargo_fk where cargo_fk is null;

select nm_cargo, nm_fun from cargo right join funcionario on cd_cargo = cargo_fk where cargo_fk is null;
 
/* Full outer join - somente as diferenças entre as tabelas
mostra conteúdo de todas as tabelas existentes na junção */

select nm_cargo, nm_fun from cargo full outer join funcionario on cd_cargo = cargo_fk where cargo_fk is null;

/*Exercicios*/
select * from cliente;
select * from vendedor;
select * from produto;
select * from pedido;
select * from item_pedido;

/* Exibir o nome do cliente e o seu pedido (número).
Usando a técnica chamada qualificador, pois temos mesmos nomes em tabelas diferentes */
select nome_clie, num_pedido from cliente inner join pedido on pedido.cod_clie = cliente.cod_clie order by 1;

/* Exibir o nome do vendedor e o seu pedido (número). */
select nome_ven, num_pedido from vendedor inner join pedido on pedido.cod_ven = vendedor.cod_ven order by 1;

/* Exibir o nome do cliente, nome do vendedor e o pedido (número). */
select nome_clie, num_pedido, nome_ven from pedido 
inner join cliente on cliente.cod_clie = pedido.cod_clie 
inner join vendedor on vendedor.cod_ven = pedido.cod_ven order by 1;

/* Mostre os produtos do pedido 111*/
select pedido.num_pedido, descricao from pedido
inner join item_pedido on pedido.num_pedido = item_pedido.num_pedido
inner join produto on item_produto.cod_prod = produto.cod_prod
where pedido.num_pedido = 101; 

/* Qual vendedor vendeu o produto chocolate? */
