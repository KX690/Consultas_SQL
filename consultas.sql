
-------------------------------1-------------------------------------------  
SELECT TOP 200 DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

-------------------------------2-------------------------------------------  
SELECT Posts.Title, Users.DisplayName
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id

-------------------------------3-------------------------------------------  
SELECT Users.DisplayName, AVG(Posts.Score) AS promedio_score
FROM Posts
INNER JOIN Users ON Users.Id = Posts.OwnerUserId
GROUP BY Posts.OwnerUserId, Users.DisplayName;

--------------------------------4-------------------------------------------  
SELECT TOP 200 Users.DisplayName
FROM Users
WHERE Users.Id IN
(SELECT Comments.UserId
FROM Comments
GROUP BY Comments.UserId
HAVING COUNT (Comments.Id) > 100);

-------------------------------5-------------------------------------------  
UPDATE Users SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = ' ';
PRINT 'La actualización se realizó correctamente.';

-------------------------------6-------------------------------------------  
DECLARE @NumComentariosEliminados INT;
DELETE Comments 
FROM Comments 
INNER JOIN Users ON Comments.UserId = Users.Id 
WHERE Users.Reputation < 100; 
SET @NumComentariosEliminados = @@ROWCOUNT; 
PRINT 'Se eliminaron ' + CAST(@NumComentariosEliminados AS VARCHAR) + ' comentarios realizados por usuarios con menos de 100 de reputación.';


-------------------------------7-------------------------------------------  
publicaciones, comentarios y medallas
SELECT TOP 200 Users.DisplayName,
COALESCE(P.Numero_de_Publicaciones, 0) AS Total_Posts, --si encuentra null convierte a 0
COALESCE(C.Numero_de_Comentarios, 0) AS Total_Comments,
COALESCE(B.Numero_de_Medallas, 0) AS Total_Badges
FROM Users
LEFT JOIN (SELECT OwnerUserId, COUNT(*) AS Numero_de_Publicaciones FROM Posts GROUP BY OwnerUserId) --numero total de veces que encontro un posteo con el mismo id
P ON Users.Id = P.OwnerUserId
LEFT JOIN (SELECT UserId, COUNT(*) AS Numero_de_Comentarios FROM Comments GROUP BY UserId) 
C ON Id = C.UserId
LEFT JOIN (SELECT UserId, COUNT(*) AS Numero_de_Medallas FROM Badges GROUP BY UserId) 
B ON Id = B.UserId;


-------------------------------8-------------------------------------------  
SELECT TOP 10 Title, Score
FROM Posts
ORDER BY Score DESC;

-------------------------------9-------------------------------------------  
SELECT TOP 5 Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;
