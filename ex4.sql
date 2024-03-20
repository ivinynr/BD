--1
select PrecoUnitario from Produtos 
where PrecoUnitario BETWEEN 10.00 AND 30.00

--2
select PrecoUnitario from Produtos 
where PrecoUnitario > 100.00

--3
select COUNT(*) as TotalSemTelefoneResidencial from Funcionarios 
where TelefoneResidencial IS NULL

--4
select NomeDoProduto, UnidadesEmEstoque, NivelDeReposicao from Produtos 
where UnidadesEmEstoque < NivelDeReposicao

--5
select CodigoDaCategoria, PrecoUnitario from Produtos 
where CodigoDaCategoria IN (1, 2, 3) AND PrecoUnitario BETWEEN 10.00 AND 50.00

--6
select * from Clientes 
where Fax IS NULL


--7
select Nome, DataDeNascimento from Funcionarios 
where DataDeNascimento BETWEEN '1955-01-01' AND '1963-12-31' 
ORDER BY Nome


--8
select Nome, Tratamento from Funcionarios 
where Tratamento LIKE 'Sr.%' 
ORDER BY Nome


--9
select c.CodigoDoCliente, SUM(p.Frete) as TotalFrete from Clientes c JOIN Pedidos p on c.CodigoDoCliente = p.CodigoDoCliente 
group by c.CodigoDoCliente


--10
select * from Funcionarios 
where Tratamento = 'Dr.' AND Pais = 'EUA' AND TelefoneResidencial LIKE '%555%' 
order by Nome


--11
select CodigoDoProduto, NomeDoProduto, PrecoUnitario from Produtos 
where UnidadesEmEstoque <= 3 
ORDER BY NomeDoProduto Desc


--12
select * from Funcionarios 
where DataDeNascimento < '1960-12-31' AND Cidade = 'London' 
ORDER BY Nome



--13
select NomeDoProduto, PrecoUnitario, Descricao from Produtos p JOIN Categorias c on p.CodigoDaCategoria = c.CodigoDaCategoria 
where Descricao LIKE '%chocolate' AND PrecoUnitario >= 15.00
ORDER BY PrecoUnitario desc


--14
select CodigoDoFuncionario, Nome from Funcionarios
where Nome NOT LIKE 'A%' AND Nome NOT LIKE 'M%' 
ORDER BY Nome


--15
select * from Pedidos p JOIN Transportadoras t on p.CodigoDaTransportadora = t.CodigoDaTransportadora 
where NomeDaEmpresa LIKE 'Federal%' AND p.Frete >= 100.00
ORDER BY NumeroDoPedido


--16
select * from Clientes 
where NomeDoContato LIKE 'C%'


--17
select * from Funcionarios
where Nome LIKE '_a%'


--18
select * from Funcionarios


--19
select * from Funcionarios 
where Pais = 'EUA'


--20
select CodigoDaCategoria, NomeDaCategoria, Descricao from Categorias 
where NomeDaCategoria LIKE 'B%' OR NomeDaCategoria LIKE 'C%'


--21
select * from Funcionarios
where TelefoneResidencial IS NOT NULL


--22
select * from Funcionarios 
where TelefoneResidencial IS NULL


--23
select NumeroDoPedido, CodigoDoProduto, (PrecoUnitário * Quantidade) as PrecoTotal from Detalhes_do_Pedido d 
where (PrecoUnitário * Quantidade) >= 200.00


--24
select CodigoDoFornecedor, NomeDaEmpresa, NomeDoContato from Fornecedores
where Pais = 'Alemanha' OR Pais = 'Japão'


--25
select * from Fornecedores 
where Pais <> 'Alemanha' AND Pais <> 'Japão'


--26
select PrecoUnitario, (PrecoUnitario * 1.25) as PrecoDeVenda, (PrecoUnitario * 1.25) - PrecoUnitario as AdicionalVenda from Produtos 
where (PrecoUnitario * 1.25) > 200.00


--27
select * from Fornecedores 
where NomeDoContato LIKE '%s'


--28
select * from Pedidos
where Frete < 30.00


--29
select * from Pedidos 
where PaisDeDestino = 'México'


--30
select * from Pedidos 
where PaisDeDestino = 'Alemanha' OR PaisDeDestino = 'Itália' OR PaisDeDestino = 'França'


--31
select * from Funcionarios 
where Cargo = 'Representante de Vendas' AND Tratamento = 'Sr.'


--32
select * from Funcionarios 
where Tratamento <> 'Sra.'


--33
select Nome, DATEDIFF(YEAR, DataDeNascimento, GETDATE()) as Idade from Funcionarios
where DATEDIFF(YEAR, DataDeNascimento, GETDATE()) > 20


--34
select * from Funcionarios 
where DataDeContratacao IN ('1993-04-01', '1993-11-01')


--35
select CodigoDoFuncionario, Nome, Supervisor from Funcionarios 
where Supervisor = '2'


--36
select NomeDaCategoria, CodigoDaCategoria from Categorias 
where NomeDaCategoria LIKE '%massas%' OR NomeDaCategoria LIKE '%doces%'


--37
select NumeroDoPedido, CodigoDoCliente from Pedidos 
where DATEDIFF(DAY, DataDeEntrega, DataDeEnvio) > 30


--38
select NumeroDoPedido from Pedidos 
where DATEDIFF(DAY, DataDeEnvio, DataDeEntrega) BETWEEN 10 AND 15


--39
select NumeroDoPedido from Pedidos
where DataDeEnvio IS NULL


--40
select NumeroDoPedido, CodigoDoProduto, Quantidade from Detalhes_do_Pedido 
where Quantidade >= 40


--41
select NumeroDoPedido as Pedido, CodigoDoProduto as Produto from Detalhes_do_Pedido 
where Desconto BETWEEN 10 AND 15


--42
select NumeroDoPedido from Pedidos
where DATEPART(YEAR, DataDeEntrega) = 1996 AND DATEPART(QUARTER, DataDeEntrega) = 3


--43
select NumeroDoPedido from Pedidos
where DATEPART(YEAR, DataDeEntrega) = 1997 AND DATEPART(QUARTER, DataDeEntrega) = 2


--44
select Nome from Funcionarios 
where MONTH(DataDeNascimento) = 8


--45
select CodigoDaTransportadora from Transportadoras 
where Telefone IS NULL


--46
select NomeDaEmpresa as Empresa, NomeDoContato as Contato, Telefone from Fornecedores 
where Fax IS NOT NULL


--47
select Nome, DataDeContratacao as DataDoContrato from Funcionarios 
where YEAR(DataDeContratacao) NOT BETWEEN 1992 AND 1994


--48
select NomeDaEmpresa, NomeDoContato from Clientes 
where CodigoDoCliente LIKE '_A%' AND CodigoDoCliente LIKE '%R'


--49
select NumeroDoPedido as Pedido, DataDoPedido as 'Dt Pedido' from Pedidos 
where CodigoDoCliente LIKE '[A-E]%'


--50
select NomeDoContato, NomeDoContato, CodigoDoCliente from Clientes 
where NomeDoContato NOT IN ('B', 'E', 'J', 'G')
