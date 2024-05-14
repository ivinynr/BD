--1
create view View_FornecedorPais as 
select NomeDaEmpresa, Endereco,
Pais from Fornecedores

--2
creat view View_Funcionarios as 
select*from FuncionariosWhere Tratamento='Sra'

--3
create view View_TotalPedidosPorCliente as 
select NomeDaEmpresa, TotalPedidos from Clientes

--4
create view View_TotalFuncionario as 
select f.Cargo,
        f.Nome,
       count (p.PedidoID) as TotalPedidos
	   from funcionarios f 
	   join Pedidos p on f.FuncionarioID=p.FuncionarioID
	   group by f.Cargo,f.Nome
--5
alter view View_FornacedorPais as 
select NomeDaEmpresa,Endereco,Pais,Cidade from Fornecedores
--6
create view View_TotalCargo as 
select f.Cargo,
    
       count (p.PedidoID) as TotalPedidos
	   from funcionarios f 
	   join Pedidos p on f.FuncionarioID=p.FuncionarioID
	   group by f.Cargo

--7
drop view View_TotalFuncionario

--8 
create view View_FornecedoresCidade as 
select NomeDaEmpresa, Endereco, Cidade from Fornecedores
where Cidade in ('London','Osaka','Berlim','Sao Paulo')

--9
select NomeDaEmpresa,Endereco from View_FornecedoresCidade
where Cidade= 'Sao Paulo'

--10
select f.Nome
from Funcionarios f
join View_TotalCargo vc on f.Cargo= vc.Cargowhere vc.Cargo='Representante de Vendas'

