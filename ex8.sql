--1
alter table Pedidos
add Total_Pedido smallmoney

--2
update Pedidos
SET Total_Pedido = (
    SELECT SUM(PrecoUnitário * Quantidade) 
    FROM Detalhes_do_Pedido 
    WHERE Detalhes_do_Pedido.NumeroDoPedido = Pedidos.NumeroDoPedido

--3
create or alter trigger InformarNumeroLinhasClientes
on Clientes
after insert as begin
declare @NumeroLinhas int;
select @NumeroLinhas = COUNT(*) from Clientes;
print 'Número de linhas na tabela Cliente: ' + CAST(@NumeroLinhas as varchar);
end;

--4
create or alter trigger AtualizarTotalPedido
on Detalhes_do_Pedido
after insert as begin 
update Pedidos
    set Total_Pedido = (
        select sum(PrecoUnitário * Quantidade)
        from inserted
        where inserted.NumeroDoPedido = Pedidos.NumeroDoPedido
    )
    where NumeroDoPedido IN (
        select NumeroDoPedido
        from inserted
    );
end;


--5
create or alter trigger VerificarEstoque
on Detalhes_do_Pedido
after insert as begin 
    declare @ProdutoID int;
    declare @QuantidadePedido int;
    declare @QuantidadeEstoque int;

select @ProdutoID = NumeroDoPedido, @QuantidadePedido = Quantidade from inserted;

select @QuantidadeEstoque = Estoque
from Estoque
where ProdutoID = @ProdutoID;

if @QuantidadePedido > @QuantidadeEstoque
begin
RAISEERROR('Quantidade solicitada do produto excede a quantidade em estoque. Impossível fornecer o produto.', 16, 1);
        ROLLBACK TRANSACTION;
    end;
end;

--6
create or alter trigger ExcluirDetalhesPedido
on Pedidos
after delete as begin 
    delete from Detalhes_do_Pedido
    WHERE PedidoID in (select deleted.PedidoID from deleted);
end;
