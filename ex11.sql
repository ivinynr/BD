--1
select NomeDoProduto, PrecoUnitario, (PrecoUnitario * 1.5) as Aumento5Percent from Produtos p 
join Categorias c 
on p.CodigoDaCategoria = c.CodigoDaCategoria 
where NomeDaCategoria = 'Bebidas';

go
create procedure AumentoPrecoBebidas 
as begin 
	update Produtos 
	set PrecoUnitario = PrecoUnitario * 1.05 
	from Produtos p JOIN Categorias c ON 
	p.CodigoDaCategoria = c.CodigoDaCategoria 
	where c.NomeDaCategoria = 'Bebidas'
end 

--2
select NumeroDoPedido, p.CodigoDaTransportadora, Frete from Pedidos p 
join Transportadoras t on p.CodigoDaTransportadora = t.CodigoDaTransportadora;

go
create procedure AlterarFretePago
as begin
	update Pedidos 
	set Frete = Frete - 0.3 
	from Pedidos p JOIN Transportadoras t
	on p.CodigoDaTransportadora = t.CodigoDaTransportadora
	where t.NomeDaEmpresa = 'Speedy Express'

	update Pedidos 
	set Frete = Frete - 0.7 
	from Pedidos p JOIN Transportadoras t
	on p.CodigoDaTransportadora = t.CodigoDaTransportadora
	where t.NomeDaEmpresa = 'United Package'
end

--3
go
create procedure Aumentar5Unidades 
as begin
	update Produtos
	set UnidadesEmEstoque = UnidadesEmEstoque + 5
	from Produtos p JOIN Fornecedores f on 
	p.CodigoDoFornecedor = f.CodigoDoFornecedor
	where f.NomeDaEmpresa = 'Norske Meierier';
end

--4
select * from Produtos

go 
create procedure ExibirCustoProduto 
@IDProduto int
as begin
	declare @PrecoCustoProduto decimal(10,2)
	declare @PrecoMedioProduto decimal(10,2)
	
	select @PrecoCustoProduto = PrecoUnitario from Produtos where CodigoDoProduto = @IDProduto;

	select @PrecoMedioProduto = AVG(PrecoUnitario) from Produtos;

	if @PrecoCustoProduto > @PrecoMedioProduto
    begin
        print 'O preço de custo desse produto é maior do que o preço médio dos produtos.';
    end
    else if @PrecoCustoProduto < @PrecoMedioProduto
    begin
        print @PrecoCustoProduto
		print @PrecoMedioProduto
		print 'O preço de custo desse produto é menor do que o preço médio dos produtos.';
    end
    else
    begin
        print 'O preço de custo desse produto é igual ao preço médio dos produtos.';
    end
end

EXEC ExibirCustoProduto @IDProduto = 1;

--5
go
create procedure EliminarProdutosPorCategoria
@NomeCategoria VARCHAR(100)
as begin
    declare @CategoriaID int;

    select @CategoriaID = c.CodigoDaCategoria
    from Categorias c
    where c.NomeDaCategoria = @NomeCategoria;

    delete from Produtos
    where CodigoDaCategoria = @CategoriaID;
end

select p.CodigoDaCategoria, c.NomeDaCategoria from Produtos p 
join Categorias c on p.CodigoDaCategoria = c.CodigoDaCategoria;

--6
go
create procedure ProdutosAbaixoDaQuantidade
@Quantidade int
as begin
    if EXISTS (select * from Produtos where UnidadesEmEstoque < @Quantidade)  
    begin 
        select NomeDoProduto from Produtos where UnidadesEmEstoque < @Quantidade;
    end
    else
    begin
        print 'Não há produtos abaixo da quantidade especificada.';
    end
end

EXEC ProdutosAbaixoDaQuantidade @Quantidade = 20

--7
go
create procedure RelatorioAniversariantesDoMes
    @Mes int
as begin
    select 
        Nome,
        DataDeNascimento,
        YEAR(GETDATE()) - YEAR(DataDeNascimento) - 
        case 
            when MONTH(GETDATE()) < MONTH(DataDeNascimento) OR 
                 (MONTH(GETDATE()) = MONTH(DataDeNascimento) AND DAY(GETDATE()) < DAY(DataDeNascimento)) 
            then 1 
            else 0 
        end as  Idade
    from 
        Funcionarios
    where 
        MONTH(DataDeNascimento) = @Mes;
end

EXEC RelatorioAniversariantesDoMes @Mes = 5

--8
go
create procedure InserirTransportadora
    @NomeEmpresa VARCHAR(100),
    @Telefone VARCHAR(20)
as begin
    insert into Transportadoras (NomeDaEmpresa, Telefone)
    values (@NomeEmpresa, @Telefone);
end

--9
go
create procedure DiminuirFretePorTransportadoraEMes
    @NomeTransportadora VARCHAR(100),
    @Mes INT
as begin
    update Pedidos
    set Frete = Frete - 0.1 * Frete -- Diminui o frete em 10%
    from Pedidos p
    join Transportadoras t on p.CodigoDaTransportadora = t.CodigoDaTransportadora
    where t.NomeDaEmpresa = @NomeTransportadora
    AND MONTH(DataDoPedido) = @Mes;
end


--10
go
create procedure ConsultarPrecoEmRelacaoAoCusto
    @Preco decimal(10, 2),
    @Apoio varchar(10) output
as begin
    if EXISTS (select * from Detalhes_do_Pedido where (PrecoUnitário * Quantidade) > @Preco)
        set @Apoio = 'Acima';
    else if EXISTS (select * from Detalhes_do_Pedido where (PrecoUnitário * Quantidade) < @Preco)
        set @Apoio = 'Abaixo';
    else
        set @Apoio = 'Igual';
end
