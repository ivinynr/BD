--1
select distinct frete from Pedidos

--2
select count(*) from Funcionarios
where year(DataDeContratacao)=1992

--3
select count(*) from Fornecedores
where Pais='Alemanha'

--4
select sum(Quantidade) as TotalQuantidadesVendidas from Detalhes_do_Pedido

--5
select max(Frete) as FreteMaisCaro from Pedidos

--6
select min(Desconto) as DescontoMaisBarato from Detalhes_do_Pedido

--7
select count(*) as TotalDeProdutosDeCondimentos from Produtos
where CodigoDaCategoria = 2

--8
select count(*) as TotalDeCategoriasComC from Categorias
where left(NomeDaCategoria, 1) = 'C'

--9
select count(*) as TotalDeProdutosComEstoqueBaixo from Produtos
where UnidadesEmEstoque < NivelDeReposicao

--10
select sum(PrecoUnitario) as TotalPrecoUnitario from Produtos

--11
select count(PrecoUnitário * Quantidade) as QuantidadeVendaProdutos from Detalhes_do_Pedido
where CodigoDoProduto=51


--12
select count(*) as TotalDePedidos from Pedidos
where year(DataDoPedido) = 1996
AND CodigoDoCliente = 'Romey'


--13
select count(*) as TotalDeAniversarios from Funcionarios
where MONTH(DataDeNascimento) =7

--14
select count(*) as TotalDeProdutosComCGN from Produtos
where left(NomeDoProduto,1) in ('C','G','N')

--15
select count(*) as QuantidadeClienteLocalizados from Clientes
where Pais in ('Alemanha','Mexico','Reino unido')

--16
select count(*) as NaoPossuiemfax from Clientes
where Fax is NULL or Fax=''

--17
select count(PrecoUnitario*UnidadesEmEstoque) TotalEmEstoque from Produtos

--18
select count(PrecoUnitário*Quantidade) as TotalVendas from Detalhes_do_Pedido


--19
select count(PrecoUnitário*Quantidade) as TotalVendas from Detalhes_do_Pedido
where CodigoDoProduto=19

--20
select sum(Frete) as TotalDeFretePago from Pedidos
join Clientes on Pedidos.CodigoDoCliente = Clientes.CodigoDoCliente
where Clientes.CodigoDoCliente = 'Lilas'
