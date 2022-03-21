<H1>POSTGRESQL</H1>
<?php
try {
	$pdo = new PDO("pgsql:host=localhost;port=5432;dbname=postgres;options='--client_encoding=LATIN1'", "postgres", "123456");
	$pdo->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
	$pdo->setAttribute( PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC );
} catch (PDOException $e) {
	echo "Falha ao conectar ao banco de dados. <br/>";
	die($e->getMessage());
}

$query = "SELECT * FROM pg_catalog.pg_tables";
$stmt = $pdo->prepare($query);
$allregs = $pdo->prepare($query);
$rows = $stmt->fetchAll();
$rows = array();
$count = 0;

if ($stmt->execute()) {        
	$rows = $stmt->fetchAll();
	$cols = $stmt->fetchAll(PDO::FETCH_COLUMN);

	echo "<table width='400px'>";

	foreach ($rows as $r) {
			echo "<tr>";
			echo "<td>" . $r['schemaname'] . "</td>";
			echo "<td>" . $r['tablename'] . "</td>";
			echo "<td>" . $r['tableowner'] . "</td>";
			echo "<td>" . $r['tablespace'] . "</td>";
			echo "<td>" . $r['hasindexes'] . "</td>";
			echo "<td>" . $r['hasrules'] . "</td>";
			echo "<td>" . $r['hastriggers'] . "</td>";
			echo "</tr>";
	}

	echo "</table>";
}
else {
	die("Falha ao executar a SQL.. #2");
}
?>