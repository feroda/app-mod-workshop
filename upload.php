<?php
include 'config.php';

if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['image'])) {

    // Generate a unique, random filename to avoid collisions and predictable names
    $filename = basename($_FILES['image']['name']);
    $destination = 'uploads/' . $filename;

    // Get the file extension
    $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));

    // Allow only specific image file types
    $allowed_extensions = ['jpg', 'jpeg', 'png', 'gif'];

    if (in_array($ext, $allowed_extensions)) {
        if (move_uploaded_file($_FILES['image']['tmp_name'], $destination)) {
            $stmt = $pdo->prepare("INSERT INTO images (user_id, filename) VALUES (?, ?)");
            $stmt->execute([$_SESSION['user_id'], $destination]);
            echo "Immagine caricata con successo!";
        } else {
            echo "Errore nel caricamento dell'immagine.";
        }
    } else {
        echo "Tipo di file non consentito.";
    }
}
?>

<form method="post" enctype="multipart/form-data">
    <input type="file" name="image" required />
    <button type="submit">Carica Immagine</button>
</form>