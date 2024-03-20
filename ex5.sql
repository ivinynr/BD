--1
select p.NumeroDoPedido,c.NomeDaEmpresa,c.Telefone,c.Fax from Pedidos p
join Clientes c on p.CodigoDoCliente = c.CodigoDoCliente

--2
select c.CodigoDoCliente,c.NomeDaEmpresa,p.DataDoPedido,p.Frete from Clientes c
join Pedidos p on c.CodigoDoCliente = p.CodigoDoCliente

--3
select f.CodigoDoFuncionario,f.Nome,f.Cargo,p.CodigoDoCliente,p.DataDoPedido from  Pedidos p
join Funcionarios f on p.CodigoDoFuncionario = f.CodigoDoFuncionario

--4
select p.NumeroDoPedido,p.DataDoPedido,p.DataDeEntrega,t.NomeDaEmpresa from Pedidos p
join Transportadoras t on p.CodigoDaTransportadora = t.CodigoDaTransportadora
group by  p.NumeroDoPedido


--5
select f.Nome as NomeDoFuncionario,p.NumeroDoPedido,c.NomeDaEmpresa from Pedidos p
join Funcionarios f on p.CodigoDoFuncionario = f.CodigoDoFuncionario
join Clientes c on p.CodigoDoCliente = c.CodigoDoCliente


--6
select p.NomeDoProduto,c.NomeDaCategoria,f.NomeDaEmpresa as NomeDoFornecedor from Produtos p
join Categorias c on p.CodigoDaCategoria = c.CodigoDaCategoria
join Fornecedores f on p.CodigoDoFornecedor = f.CodigoDoFornecedor
group by p.NomeDoProduto, c.NomeDaCategoria, f.NomeDaEmpresa

-- 7
Select NomeDoProduto, PrecoUnitario, Quantidade, NumeroDoPedido, NomeDaEmpresa From Produtos p
join Detalhes_do_Pedido d on p.CodigoDoProduto = d.CodigoDoProduto
join Fornecedores f on p.CodigoDoFornecedor = f.CodigoDoFornecedor

--8
select NomeDoProduto,DataDoPedido,c.NomeDaEmpresa from Pedidos p
join Produtos pr on p.CodigoDoProduto = pr.CodigoDoProduto
join Clientes c on p.CodigoDoCliente= c.CodigoDoCliente

--9
select f.NomeDaEmpresa,pr.NomeDoProduto,pr.PrecoUnitario,p.DataDoPedido,c.IDCliente from Pedidos p
join Produtos pr on p.CodigoDoProduto=pr.CodigoDoProduto
join Fornecedores f on pr.CodigoDoFornecedor = f.CodigoDoFornecedor
join Clientes c on p.CodigoDoCliente = c.CodigoDoCliente

--10
select f.Nome,c.NomeDaEmpresa from Pedidos p
join Funcionarios f on p.CodigoDoFuncionario = f.CodigoDoFuncionario
join Clientes c on p.CodigoDoCliente = c.CodigoDoCliente


--11
select c.NomedaCategoria,NomeDoProduto, PrecoUnitario,Quantidade, Desconto from Produtos pr
join Categorias c on pr.CodigoDaCategoria=c.CodigoDaCategoria
join Detalhes_do_Pedido dp on pr.QuantidadePorUnidade= dp.Quantidade

--12
select Pedidos.NumeroDoPedido,
       Pedidos.DataDoPedido,
       Clientes.CodigoDoCliente,
       Transportadoras.NomeDaEmpresa
from Pedidos
join Clientes on Pedidos.CodigoDoCliente = Clientes.CodigoDoCliente
join Transportadoras on Pedidos.CodigoDaTransportadora = Transportadoras.CodigoDaTransportadora;


--13
select Produtos.CodigoDoProduto,
       Produtos.NomeDoProduto,
       Produtos.CodigoDoFornecedor,
       Fornecedores.NomeDaEmpresa
from Produtos
join Fornecedores on Produtos.CodigoDoFornecedor = Fornecedores.CodigoDoFornecedor;

--14
select Funcionarios.Nome,
       Pedidos.NumeroDoPedido,
       Transportadoras.NomeDaEmpresa
from Pedidos
join Funcionarios on Pedidos.CodigoDoFuncionario = Funcionarios.CodigoDoFuncionario
join Transportadoras on Pedidos.CodigoDaTransportadora = Transportadoras.CodigoDaTransportadora;

--15
select NomeDoProduto from Produtos
join Fornecedores on Produtos.CodigoDoFornecedor=Fornecedores.CodigoDoFornecedor


--16
select f.nome, sum(d.Quantidade*d.PrecoUnitário) Total, (sum(d.Quantidade*d.PrecoUnitário) * 0.05) Comissao1,  (sum(d.Quantidade*d.PrecoUnitário) * 0.1)Comissao2 from Funcionarios f
join Pedidos p on f.CodigoDoFuncionario=p.CodigoDoFuncionario
join Detalhes_do_Pedido d on p.NumeroDoPedido=d.NumeroDoPedido
group by f.Nome

--17
select c.NomeDaCategoria, sum (dp. Quantidade) from Detalhes_do_Pedido dp
join Produtos p on dp.CodigoDoProduto = p.CodigoDoProduto
Join Categorias c  on p.CodigoDaCategoria=c.CodigoDaCategoria
group by c.NomeDaCategoria

--18
select t.NomeDaEmpresa, sum(Frete) from Pedidos p
Join Transportadoras t on p.CodigoDaTransportadora = t.CodigoDaTransportadora
group by t.NomeDaEmpresa

--19
select c. NomeDoContato, sum(dp.Desconto) from Clientes c 
join Pedidos p on c.CodigoDoCliente=p.CodigoDoCliente 
join Detalhes_do_Pedido dp on p.NumeroDoPedido=dp.NumeroDoPedido
group by c.NomeDoContato

--20
select f.Nome, sum(dp. Desconto) from Funcionarios f 
join Pedidos p on f.CodigoDoFuncionario=p.CodigoDoFuncionario 
join Detalhes_do_Pedido dp on p.NumeroDoPedido=dp.NumeroDoPedido 
group by f. Nome