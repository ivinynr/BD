--1
select NomeDoProduto from Produtos
where PrecoUnitario > (select AVG(PrecoUnitario) from produtos)

--2
select c.CodigoDoCliente from Clientes c
join Produtos p on c.IDCliente = p.CodigoDoProduto
where p.CodigoDoProduto = (select CodigoDoProduto from produtos where NomeDoProduto = 'Maxilaku')

--3
select NumeroDoPedido from Pedidos
where NumeroDoPedido in (select NumeroDoPedido from Detalhes_do_Pedido
group by NumeroDoPedido having count(*) > 5
);

--4
select c.CodigoDoCliente,(select SUM(dp.PrecoUnitário) 
     FROM Detalhes_do_Pedido dp 
     WHERE dp.NumeroDoPedido = p.NumeroDoPedido) AS total_pedido
FROM 
    clientes c
JOIN 
    pedidos p ON c.IDCliente = p.CodigoDoCliente
WHERE 
    (SELECT SUM(dp.PrecoUnitário) 
     FROM Detalhes_do_Pedido dp
     WHERE dp.NumeroDoPedido = p.NumeroDoPedido) = (
         SELECT MAX()
         FROM (
             SELECT SUM(dp.PrecoUnitário) AS total_valor_pedido
             FROM Detalhes_do_Pedido dp
             GROUP BY dp.NumeroDoPedido
         ) AS max_pedido_por_cliente
     )


---5
select p.NomeDoProduto, MAX(dp.Quantidade) as maior_quantidade_vendida from produtos p
join Detalhes_do_Pedido dp on p.CodigoDoProduto = dp.CodigoDoProduto
group by p.NomeDoProduto;

--6
select p.NomeDoProduto, MIN(dp.PrecoUnitário) as preco_mais_baixo from produtos p
join Detalhes_do_Pedido dp on p.CodigoDoProduto = dp.CodigoDoProduto
group by p.NomeDoProduto;

--7
SELECT NumeroDoPedido
FROM pedidos
WHERE CodigoDaTransportadora = 'Speedy Express'
AND EXTRACT(YEAR from  DataDoPedido) = 1996
AND EXTRACT(QUARTER FROM DataDoPedido) = 2;

--8
SELECT NumeroDoPedido
FROM pedidos
WHERE (EXTRACT(MONTH FROM data_pedido) = 4 AND EXTRACT(YEAR FROM data_pedido) = 1996)
   OR (EXTRACT(MONTH FROM data_pedido) = 3 AND EXTRACT(YEAR FROM data_pedido) = 1997);


--9
SELECT p.NumeroDoPedido
FROM pedidos p
JOIN Detalhes_do_Pedido ip ON p.NumeroDoPedido = ip.NumeroDoPedido
WHERE EXTRACT(YEAR FROM p.data_pedido) = 1997
AND EXTRACT(QUARTER FROM p.data_pedido) = 2
AND ((ip.PrecoUnitário * ip.quantidade) - ip.desconto) > (
    SELECT AVG((ip2.PrecoUnitário * ip2.quantidade) - ip2.desconto)
    FROM pedidos p2
    JOIN Detalhes_do_Pedido ip2 ON p2.NumeroDoPedido = ip2.NumeroDoPedido
    WHERE EXTRACT(YEAR FROM p2.data_pedido) = 1997
    AND EXTRACT(QUARTER FROM p2.data_pedido) = 2
);

--10
SELECT f.CodigoDoFornecedor
FROM fornecedores f
JOIN produtos p ON f.CodigoDoFornecedor = p.CodigoDoFornecedor
WHERE p.PrecoUnitario > (
    SELECT AVG(PrecoUnitario)
    FROM produtos
    WHERE CodigoDoFornecedor = p.CodigoDoFornecedor
);

--11
SELECT NomeDoProduto, PrecoUnitario
FROM produtos
WHERE CodigoDaCategoria = (
    SELECT CodigoDaCategoria
    FROM categorias
    WHERE NomeDaCategoria = 'Confeitos'
);
--12
SELECT NumeroDoPedido, CodigoDoCliente, DataDoPedido
FROM pedidos
WHERE CodigoDaTransportadora IN (
    SELECT CodigoDaTransportadora
    FROM transportadoras
    WHERE CodigoDaTransportadora IN ('Speedy Express', 'Federal Shipping')
);
--13
SELECT c.NomeDaEmpresa, p.NumeroDoPedido, p.DataDoPedido
FROM clientes c
JOIN pedidos p ON c.IDCliente = p.CodigoDoCliente
WHERE (EXTRACT(MONTH FROM p.data_pedido) = 8 AND EXTRACT(YEAR FROM p.data_pedido) = 1996)
   OR (EXTRACT(MONTH FROM p.data_pedido) = 9 AND EXTRACT(YEAR FROM p.data_pedido) = 1997);

   --14
   SELECT p.NumeroDoPedido
FROM pedidos p
JOIN clientes c ON p.CodigoDoCliente = c.CodigoDoCliente
WHERE c.fax IS NULL;


--15
SELECT c.CodigoDoCliente
FROM clientes c
JOIN (
    SELECT CodigoDoCliente, SUM(valorTotal) AS total_pedido
    FROM pedidos
    GROUP BY CodigoDoCliente
) t ON c.CodigoDoCliente = t.CodigoDoCliente
WHERE t.total_pedido > (
    SELECT AVG(total_pedido)
    FROM (
        SELECT SUM(valor_total) AS total_pedido
        FROM pedidos
        GROUP BY CodigoDoCliente
    ) AS media_pedido
);

--16
SELECT Nome
FROM funcionarios
WHERE DataDeNascimento > (SELECT AVG(DataDeNascimento) FROM funcionarios);
--17
SELECT f.Nome
FROM funcionarios f
JOIN (
    SELECT CodigoDoFuncionario, COUNT(NumeroDoPedido) AS total_pedidos
    FROM pedidos
    GROUP BY CodigoDoFuncionario
) p ON f.CodigoDoFuncionario = p.CodigoDoFuncionario
WHERE p.total_pedidos > (SELECT AVG(total_pedidos) FROM (SELECT COUNT(NumeroDoPedido) AS total_pedidos FROM pedidos GROUP BY CodigoDoFuncionario) AS media_pedidos);


--18
SELECT p.NumeroDoPedido
FROM pedidos p
JOIN clientes c ON p.CodigoDoCliente = c.CodigoDoCliente
WHERE c.fax IS NULL;

--19
SELECT c.CodigoDoCliente
FROM clientes c
WHERE c.CodigoDoCliente NOT IN (
    SELECT CodigoDoCliente
    FROM pedidos
);

--20
SELECT DISTINCT p.NumeroDoPedido
FROM pedidos p
JOIN Detalhes_do_Pedido ip ON p.NumeroDoPedido = ip.NumeroDoPedido
JOIN produtos pr ON ip.CodigoDoProduto = pr.CodigoDoProduto
JOIN categorias c ON pr.CodigoDaCategoria = c.CodigoDaCategoria
WHERE c.NomeDaCategoria = 'Bebidas';

--21
SELECT DISTINCT f.Nome
FROM funcionarios f
JOIN pedidos p ON f.CodigoDoFuncionario = p.CodigoDoFuncionario
JOIN clientes c ON p.CodigoDoCliente = c.CodigoDoCliente
WHERE c.CodigoDoCliente IN ('Antonio Moreno Taquería', 'Blauer See Delikatessen', 'Ernst Handel');

--22
SELECT c.CodigoDoCliente
FROM clientes c
JOIN pedidos p ON c.CodigoDoCliente = p.CodigoDoCliente
WHERE p.Frete > (
    SELECT AVG(Frete)
    FROM pedidos
);

--23
SELECT NomeDoProduto
FROM produtos
WHERE Descontinuado < (
    SELECT AVG(Descontinuado)
    FROM produtos
);

--24
SELECT f.CodigoDoFornecedor
FROM fornecedores f
JOIN produtos p ON f.CodigoDoFornecedor = p.CodigoDoFornecedor
GROUP BY f.CodigoDoFornecedor
HAVING AVG(p.PrecoUnitario) < (
    SELECT AVG(PrecoUnitario)
    FROM produtos
);


--25
SELECT NomeDoProduto
FROM produtos
WHERE UnidadesEmEstoque < (
    SELECT AVG(QuantidadePorUnidade)
    FROM Detalhes_do_Pedido
    GROUP BY CodigoDoProduto
);

