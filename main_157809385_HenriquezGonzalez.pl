%%%%%%%%%%%%%%%%%%%%%%% TDA FS %%%%%%%%%%%%%%%%%%%%%%%

% filesystem/5: Constructor de filesystem
% DOMINIO: Nombre (string), Drives (lista de drives), Users (lista de usuarios), Content (contenido), TimeStamp (marca de tiempo)
% META PRINCIPAL: Crear una estructura de filesystem con el timestamp dado
filesystem(Nombre, Drives, Users, Content, [Nombre, Drives, Users, Content, TimeStamp]) :-
   get_time(TimeStamp).
% filesystem/5: constructor de filesystem para obtener el timestamp ya creado, lo uso para todo menos RF1
filesystem(Nombre, Drives, Users, Content, TimeStamp, [Nombre, Drives, Users, Content, TimeStamp]).

% getDrives/2: Obtiene los Drives de un System
% DOMINIO: System (estructura de filesystem), Drives (lista de drives)
% META PRINCIPAL: Retornar la lista de drives de un System
getDrives(System, Drives) :-
   % uso el constructor que obtiene el timestamp
   filesystem(_, Drives, _, _, _, System).

% setDrives/3: Actualiza los Drives de un System
% DOMINIO: System (estructura de filesystem), UpdatedDrives (lista de drives actualizada), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Actualizar la lista de drives en un System
setDrives(System, UpdatedDrives, UpdatedSystem) :-
   filesystem(Nombre, _, Users, Content, TimeStamp, System),
   filesystem(Nombre, UpdatedDrives, Users, Content, TimeStamp, UpdatedSystem).

% exists/2: Verifica si un elemento existe en una lista de listas
% DOMINIO: Elemento (cualquier tipo), Lista de listas
% META PRINCIPAL: Verificar si el Elemento existe en alguna de las listas internas
exists(Elemento, [ListaInterna|_]) :-
   member(Elemento, ListaInterna).
% Recursive case: continue searching for the string in the remaining lists.
exists(Elemento, [_|RestoListas]) :-
   exists(Elemento, RestoListas).

 % letterDoesntExistsInSystem/2: Verifica si una Unidad no existe en el System
% DOMINIO: Unidad (string), System (estructura de filesystem)
% META PRINCIPAL: Verificar que la Unidad no exista en los drives del System 
letterDoesntExistsInSystem(Unidad, System) :-
   filesystem(_, Drives, _, _, _, System),
    \+ exists(Unidad, Drives). %  \+ es not


%%%%%%%%%%%%%%%%%%%%%%% TDA USER %%%%%%%%%%%%%%%%%%%%%%%
% getUsers/2: Obtiene los Users de un System
% DOMINIO: System (estructura de filesystem), Users (lista de usuarios)
% META PRINCIPAL: Retornar la lista de usuarios de un System
getUsers(System, Users) :-
   filesystem(_, _, Users, _, _, System).

% setAddUserInUsers/3: Añade un usuario a la lista de usuarios
% DOMINIO: Users (lista de usuarios), User (string), UpdatedUsers (lista de usuarios actualizada)
% META PRINCIPAL: Añadir un usuario a la lista de usuarios
setAddUserInUsers(Users, User, UpdatedUsers) :-
   append(Users, [User], UpdatedUsers).

% setUsers/3: Actualiza los Users de un System
% DOMINIO: System (estructura de filesystem), UpdatedUsers (lista de usuarios actualizada), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Actualizar la lista de usuarios en un System
setUsers(System, UpdatedUsers, UpdatedSystem) :-
   filesystem(Nombre, Drives, _, Content, TimeStamp, System),
   filesystem(Nombre, Drives, UpdatedUsers, Content, TimeStamp, UpdatedSystem).

% setAddUserInSystem/3: Agrega un usuario al sistema
% DOMINIO: System (estructura de filesystem), User (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza getUsers/2, setAddUserInUsers/3 y setUsers/3 para agregar un usuario al sistema
% META SECUNDARIA: Ninguna
setAddUserInSystem(System, User, UpdatedSystem) :-
   getUsers(System, Users),
   setAddUserInUsers(Users, User, UpdatedUsers),
   setUsers(System, UpdatedUsers, UpdatedSystem).


% existsUser/2: Verifica si un usuario existe en la lista de usuarios
% DOMINIO: User (string), Users (lista de usuarios)
% META PRINCIPAL: Utiliza member/2 para verificar si el usuario existe
% META SECUNDARIA: Ninguna
existsUser(User, Users) :-
   member(User, Users). % \+


%%%%%%%%%%%%%%%%%%%%%%% TDA Drive %%%%%%%%%%%%%%%%%%%%%%%
% drive/4: Constructor de drive
% DOMINIO: Unidad (string), Nombre (string), Capacidad (número), Drive (lista)
% META PRINCIPAL: Crear una estructura de drive
% META SECUNDARIA: Ninguna
drive(Unidad, Nombre, Capacidad, [Unidad, Nombre, Capacidad]).
% setAddNewDriveInDrives/3: Agrega un nuevo drive a la lista de drives
% DOMINIO: NewDrive (lista), Drives (lista de drives), UpdatedDrives (lista de drives actualizada)
% META PRINCIPAL: Utiliza append/3 para agregar un nuevo drive a la lista de drives
% META SECUNDARIA: Ninguna
setAddNewDriveInDrives(NewDrive, Drives, UpdatedDrives) :-
   append(Drives, [NewDrive], UpdatedDrives).

%%%%%%%%%%%%%%%%%%%%%%% RFS %%%%%%%%%%%%%%%%%%%%%%%
% RF1. System
% system/2: Constructor de sistema
% DOMINIO: Nombre (string), Sistema (estructura de filesystem)
% META PRINCIPAL: Utiliza filesystem/5 para crear un nuevo sistema con nombre “NewSystem”
% META SECUNDARIA: Ninguna

system(Nombre, Sistema) :-
   filesystem(Nombre, [], [], [], Sistema).


% RF2. systemAddDrive
% systemAddDrive/5: Agrega un nuevo drive al sistema
% DOMINIO: System (estructura de filesystem), Unidad (string), Nombre (string), Capacidad (número), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza letterDoesntExistsInSystem/2, drive/4, getDrives/2, setAddNewDriveInDrives/3 y setDrives/3 para agregar un nuevo drive al sistema
% META SECUNDARIA: Ninguna

systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem) :-
   letterDoesntExistsInSystem(Unidad, System), % Verifico que no existe un drive con la misma letra
   drive(Unidad, Nombre, Capacidad, NewDrive),
   getDrives(System, CurrentDrives),
   setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
   setDrives(System, UpdatedDrives, UpdatedSystem).


% systemRegister/3: Registra un nuevo usuario en el sistema
% DOMINIO: System (estructura de filesystem), User (string), UpdatedSystem (estructura de filesystem actual
% META PRINCIPAL: xxxxxxxxxx
% META SECUNDARIA: xxxxxxxx
systemRegister(System, User, UpdatedSystem) :-
   setAddUserInSystem(System, User, UpdatedSystem).

% RF4. systemLogin
% systemLogin/4: loguea un usuario al sistema
% DOMINIO: System (estructura de filesystem), User (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para loguear un usuario al sistema
% META SECUNDARIA: Ninguna
systemLogin(System, User, UpdatedSystem) :-
   existsUser(User, Users),
   setUsers(System, Users, UpdatedSystem).
% RF5. systemLogout
% systemLogout/2: Desloguea un usuario al sistema
% DOMINIO: System (estructura de filesystem), User (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemLogout(System, UpdatedSystem) :-
   setUsers(System, [], UpdatedSystem).
systemSwitchDrive(System, Letter, UpdatedSystem) :-
   getDrives(System, Drives),
   exists(Letter, Drives),
   setDrives(System, [Letter], UpdatedSystem).

% RF7. systemMkdir
% systemMkdir/3: crea un directorio en el sistema
% DOMINIO: System (estructura de filesystem), Name (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemMkdir(System, Name, UpdatedSystem) :-
   getDrives(System, Drives),
   member(Drive, Drives),
   \+ exists(Name, Drive),
   getCurrentTimestamp(Timestamp),
   createDirectory(Name, Timestamp, UpdatedDrive),
   replaceDrive(Drive, UpdatedDrive, Drives, UpdatedDrives),
   setDrives(System, UpdatedDrives, UpdatedSystem).

createDirectory(Name, Timestamp, [Name, [], Timestamp]).

replaceDrive(Drive, UpdatedDrive, Drives, UpdatedDrives) :-
    maplist(replaceDriveHelper(Drive, UpdatedDrive), Drives, UpdatedDrives).

replaceDriveHelper(Drive, UpdatedDrive, Drive, UpdatedDrive).
replaceDriveHelper(Drive, _, OtherDrive, OtherDrive).

getCurrentTimestamp(Timestamp) :-
   get_time(Stamp),
   round(Stamp, Timestamp).

% RF8. systemCd
% systemCd/3: cambia de directorio en el sistema
% DOMINIO: System (estructura de filesystem), Path (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemCd(System, Path, UpdatedSystem) :-
   getDrives(System, Drives),
   getCurrentDirectory(System, CurrentDirectory),
   splitPath(Path, Directories),
   processDirectories(Drives, CurrentDirectory, Directories, UpdatedDirectory),
   setDirectory(System, UpdatedDirectory, UpdatedSystem).
% getCurrentDirectory/2 obtiene el directorio actual del sistema
getCurrentDirectory(System, Directory) :-
   filesystem(_, _, _, _, _, Drives),
   member(Drive, Drives),
   member(Directory, Drive).

% splitPath/2 divide una ruta en una lista de directorios
splitPath(Path, Directories) :-
   atomic_list_concat(DirectoryList, '/', Path),
   exclude(=(''), DirectoryList, Directories).

% processDirectories/4 procesa los directorios de la ruta para actualizar el directorio actual
processDirectories(Drives, CurrentDirectory, [], UpdatedDirectory) :-
   UpdatedDirectory = CurrentDirectory.
processDirectories(Drives, CurrentDirectory, ["."|RestDirectories], UpdatedDirectory) :-
   processDirectories(Drives, CurrentDirectory, RestDirectories, UpdatedDirectory).
processDirectories(Drives, CurrentDirectory, [".."|RestDirectories], UpdatedDirectory) :-
   getParentDirectory(CurrentDirectory, ParentDirectory),
   processDirectories(Drives, ParentDirectory, RestDirectories, UpdatedDirectory).
processDirectories(Drives, CurrentDirectory, [Directory|RestDirectories], UpdatedDirectory) :-
   exists(Directory, CurrentDirectory),
   getChildDirectory(CurrentDirectory, Directory, ChildDirectory),
   processDirectories(Drives, ChildDirectory, RestDirectories, UpdatedDirectory).
processDirectories(Drives, CurrentDirectory, [Directory|RestDirectories], UpdatedDirectory) :-
   \+ exists(Directory, CurrentDirectory),
   processDirectories(Drives, CurrentDirectory, RestDirectories, UpdatedDirectory).

% getParentDirectory/2 obtiene el directorio padre del directorio actual
getParentDirectory(CurrentDirectory, ParentDirectory) :-
   member([ParentDirectory, _, _], CurrentDirectory).

% getChildDirectory/3 obtiene el directorio hijo con el nombre especificado dentro del directorio actual
getChildDirectory(CurrentDirectory, ChildName, ChildDirectory) :-
   member([ChildName, ChildDirectory, _], CurrentDirectory).
setDirectory([Nombre, Drives, Users, Content, TimeStamp], UpdatedDirectory, [Nombre, Drives, Users, UpdatedDirectory, TimeStamp]).

% RF9. systemAddFile
% systemAddFile/3: agrega un archivo al sistema
% DOMINIO: System (estructura de filesystem), file (file), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemAddFile(System, File, UpdatedSystem) :-
   getCurrentDirectory(System, CurrentDirectory),
   addFileToDirectory(CurrentDirectory, File, UpdatedDirectory),
   setDirectory(System, UpdatedDirectory, UpdatedSystem).

% addFileToDirectory/3 agrega un archivo al directorio actual
addFileToDirectory(CurrentDirectory, File, UpdatedDirectory) :-
   append(CurrentDirectory, [File], UpdatedDirectory).
% file/3: constructor de archivo
file(Nombre, Contenido, [Nombre, Contenido]).

% RF10. systemDel
% systemDel/3: elimina un archivo del sistema
% DOMINIO: System (estructura de filesystem), fileName (String), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemDel(System, User, Path, UpdatedSystem) :-
   getCurrentDirectory(System, CurrentDirectory),
   resolvePath(CurrentDirectory, Path, TargetDirectory),
   deleteFilesInDirectory(TargetDirectory, UpdatedDirectory),
   setDirectory(System, UpdatedDirectory, UpdatedSystem).
% resolvePath/3 resuelve la ruta especificada en el directorio de destino
resolvePath(CurrentDirectory, Path, TargetDirectory) :-
   splitPath(Path, PathSegments),
   resolvePathSegments(CurrentDirectory, PathSegments, TargetDirectory).

resolvePathSegments(TargetDirectory, [], TargetDirectory).
resolvePathSegments(CurrentDirectory, ["."|RestSegments], TargetDirectory) :-
   resolvePathSegments(CurrentDirectory, RestSegments, TargetDirectory).
resolvePathSegments(CurrentDirectory, [".."|RestSegments], TargetDirectory) :-
   getParentDirectory(CurrentDirectory, ParentDirectory),
   resolvePathSegments(ParentDirectory, RestSegments, TargetDirectory).
resolvePathSegments(CurrentDirectory, [Segment|RestSegments], TargetDirectory) :-
   getChildDirectory(CurrentDirectory, Segment, ChildDirectory),
   resolvePathSegments(ChildDirectory, RestSegments, TargetDirectory).

% deleteFilesInDirectory/2 elimina los archivos en el directorio especificado
deleteFilesInDirectory([], []).
deleteFilesInDirectory([File|RestFiles], [UpdatedFile|RestUpdatedFiles]) :-
   deleteFile(File, UpdatedFile),
   deleteFilesInDirectory(RestFiles, RestUpdatedFiles).

% deleteFile/2 elimina un archivo y lo mueve a la papelera
deleteFile([FileName, FileContent, FileTimestamp], [FileName, FileContent, FileTimestamp, DeletedTimestamp]) :-
   getTimestamp(DeletedTimestamp).



% RF11. systemCopy
% systemCopy/3: copia un archivo o directorio del sistema
% DOMINIO: System (estructura de filesystem), source (file or folder) (String) x targetpath (String), UpdatedSystem (estructura de filesystem actualizada) 
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna

systemCopy(System, Source, TargetPath, UpdatedSystem) :-
   getCurrentDirectory(System, CurrentDirectory),
   resolvePath(CurrentDirectory, Source, SourceDirectory),
   resolvePath(CurrentDirectory, TargetPath, TargetDirectory),
   copyFiles(SourceDirectory, TargetDirectory, UpdatedDirectory),
   setDirectory(System, UpdatedDirectory, UpdatedSystem).

% copyFiles/3 copia los archivos desde el directorio de origen al directorio de destino
copyFiles(SourceDirectory, TargetDirectory, UpdatedDirectory) :-
   getFilesInDirectory(SourceDirectory, Files),
   copyFilesRecursive(Files, SourceDirectory, TargetDirectory, UpdatedDirectory).

copyFilesRecursive([], _, _, []).
copyFilesRecursive([File|RestFiles], SourceDirectory, TargetDirectory, [UpdatedFile|RestUpdatedFiles]) :-
   copyFile(File, SourceDirectory, TargetDirectory, UpdatedFile),
   copyFilesRecursive(RestFiles, SourceDirectory, TargetDirectory, RestUpdatedFiles).

% copyFile/4 copia un archivo desde el directorio de origen al directorio de destino
copyFile([FileName, FileContent, FileTimestamp], SourceDirectory, TargetDirectory, [UpdatedFileName, FileContent, FileTimestamp]) :-
   atom_concat(SourceDirectory, FileName, SourceFilePath),
   atom_concat(TargetDirectory, FileName, TargetFilePath),
   read_file_to_string(SourceFilePath, FileContent, []),
   open(TargetFilePath, write, OutputStream),
   write(OutputStream, FileContent),
   close(OutputStream).

%systemCopy(S, "foo.txt", "D:/newFolder/", S1).    % Copia el archivo foo.txt a la ruta D:/newFolder/
%systemCopy(S, "folder1", "D:/newFolder/", S1).    % Copia la carpeta "folder1" a la ruta D:/newFolder/
%systemCopy(S, "*.jpg", "D:/newFolder/", S1).      % Copia solo los archivos terminados en .jpg del directorio actual


% RF12. systemMove
% systemMove/3: mueve un archivo o directorio del sistema
% DOMINIO: System (estructura de filesystem), source (file or folder) (String) x targetpath (String), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemMove(System, Source, TargetPath, UpdatedSystem) :-
   getCurrentDirectory(System, CurrentDirectory),
   resolvePath(CurrentDirectory, Source, SourceDirectory),
   resolvePath(CurrentDirectory, TargetPath, TargetDirectory),
   moveFiles(SourceDirectory, TargetDirectory, UpdatedDirectory),
   setDirectory(System, UpdatedDirectory, UpdatedSystem).

% moveFiles/3 mueve los archivos desde el directorio de origen al directorio de destino
moveFiles(SourceDirectory, TargetDirectory, UpdatedDirectory) :-
   getFilesInDirectory(SourceDirectory, Files),
   moveFilesRecursive(Files, SourceDirectory, TargetDirectory, UpdatedDirectory).

moveFilesRecursive([], _, _, []).
moveFilesRecursive([File|RestFiles], SourceDirectory, TargetDirectory, [UpdatedFile|RestUpdatedFiles]) :-
   moveFile(File, SourceDirectory, TargetDirectory, UpdatedFile),
   moveFilesRecursive(RestFiles, SourceDirectory, TargetDirectory, RestUpdatedFiles).

% moveFile/4 mueve un archivo desde el directorio de origen al directorio de destino
moveFile([FileName, FileContent, FileTimestamp], SourceDirectory, TargetDirectory, [UpdatedFileName, FileContent, FileTimestamp]) :-
   atom_concat(SourceDirectory, FileName, SourceFilePath),
   atom_concat(TargetDirectory, FileName, TargetFilePath),
   read_file_to_string(SourceFilePath, FileContent, []),
   rename_file(SourceFilePath, TargetFilePath).

%systemMove(S, "foo.txt", "D:/newFolder/", S1).    % Mueve el archivo foo.txt a la ruta D:/newFolder/
%systemMove(S, "folder1", "D:/newFolder/", S1).    % Mueve la carpeta "folder1" a la ruta D:/newFolder/


% RF13. systemRen
% systemRen/3: renombra un archivo o directorio del sistema
% DOMINIO: System (estructura de filesystem), currentname(String) x newname(String), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemRen(System, CurrentName, NewName, UpdatedSystem) :-
   getCurrentDirectory(System, CurrentDirectory),
   resolvePath(CurrentDirectory, CurrentName, CurrentPath),
   resolvePath(CurrentDirectory, NewName, NewPath),
   renameFileOrDirectory(CurrentPath, NewPath, UpdatedDirectory),
   setDirectory(System, UpdatedDirectory, UpdatedSystem).
% renameFileOrDirectory/3 cambia el nombre del archivo o carpeta en el directorio actual
renameFileOrDirectory(CurrentPath, NewPath, UpdatedDirectory) :-
   getFilesInDirectory(CurrentPath, Files),
   renameFileOrDirectoryRecursive(Files, CurrentPath, NewPath, UpdatedFiles),
   updateFilesInDirectory(CurrentPath, UpdatedFiles, UpdatedDirectory).

renameFileOrDirectoryRecursive([], _, _, []).
renameFileOrDirectoryRecursive([[FileName, FileContent, FileTimestamp]|RestFiles], CurrentPath, NewPath, [[UpdatedFileName, FileContent, FileTimestamp]|RestUpdatedFiles]) :-
   atom_concat(CurrentPath, FileName, CurrentFilePath),
   atom_concat(NewPath, UpdatedFileName, NewFilePath),
   renameFileOrDirectoryRecursive(RestFiles, CurrentPath, NewPath, RestUpdatedFiles),
   rename_file(CurrentFilePath, NewFilePath).

updateFilesInDirectory(CurrentPath, UpdatedFiles, UpdatedDirectory) :-
   getDirectoriesInDirectory(CurrentPath, Directories),
   updateDirectoriesInDirectory(CurrentPath, Directories, UpdatedDirectories),
   UpdatedDirectory = [CurrentPath, UpdatedFiles, UpdatedDirectories].

%systemRen(S, "foo.txt", "foo2.jpg", S2).    % Cambia el nombre del archivo "foo.txt" a "foo2.jpg"

% RF14. systemDir
% systemDir/3: muestra el contenido de un directorio del sistema
% DOMINIO: System (estructura de filesystem), params(String list), listaDir (string)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemDir(System, Params, ListaDir) :-
   getCurrentDirectory(System, CurrentDirectory),
   resolveDirectoryPath(CurrentDirectory, Params, DirectoryPath),
   listDirectoryContents(DirectoryPath, ListaDir).

resolveDirectoryPath(CurrentDirectory, Params, DirectoryPath).
listDirectoryContents(DirectoryPath, ListaDir).





% RF15. systemFormat
% systemFormat/4: formatea un disco del sistema
% DOMINIO: System (estructura de filesystem), drive (char), label (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna
systemFormat(System, Drive, Label, UpdatedSystem) :-
   getDrives(System, Drives),
   formatDrive(Drives, Drive, Label, UpdatedDrives),
   setDrives(System, UpdatedDrives, UpdatedSystem).
% formatDrive/4: constructor de formato de disco
formatDrive(Drives, Drive, Label, UpdatedDrives).





% RF18. systemGrep
% systemGrep/4: busca un texto en un archivo o carpeta del sistema
% DOMINIO: System (estructura de filesystem), pattern (string), fileNameOrPath (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna

systemGrep(System, Pattern, FileNameOrPath, UpdatedSystem) :-
   searchInSystem(System, Pattern, FileNameOrPath, Result),
   formatSearchResult(Result),
   UpdatedSystem = System.

searchInSystem(System, Pattern, FileNameOrPath, Result) :-
   validateFileNameOrPath(FileNameOrPath),
   getFileContent(System, FileNameOrPath, Content),
   searchPatternInContent(Content, Pattern, Result).

getFileContent(System, FileName, Content) :-
   getCurrentPath(System, CurrentPath),
   resolveFilePath(CurrentPath, FileName, FilePath),
   readFileContent(FilePath, Content).

resolveFilePath(CurrentPath, FileName, FilePath) :-
   atom_concat(CurrentPath, FileName, FilePath).

readFileContent(FilePath, Content) :-
   open(FilePath, read, Stream),
   read_string(Stream, _, Content),
   close(Stream).

searchPatternInContent(Content, Pattern, Result) :-
   split_string(Content, "\n", "\n", Lines),
   searchPatternInLines(Lines, Pattern, 1, Result).

searchPatternInLines([], _, _, []).
searchPatternInLines([Line | RestLines], Pattern, LineNumber, Result) :-
   searchPatternInLine(Line, Pattern, LineNumber, LineResult),
   NewLineNumber is LineNumber + 1,
   searchPatternInLines(RestLines, Pattern, NewLineNumber, RestResult),
   append(LineResult, RestResult, Result).

searchPatternInLine(Line, Pattern, LineNumber, Result) :-
   string_codes(Line, LineCodes),
   string_length(Pattern, PatternLength),
   searchPatternInLineCodes(LineCodes, Pattern, PatternLength, 1, LineNumber, Result).

searchPatternInLineCodes(_, _, PatternLength, Index, _, []) :-
   Index > PatternLength.
searchPatternInLineCodes(LineCodes, Pattern, PatternLength, Index, LineNumber, [Match | Result]) :-
   sub_string(LineCodes, Index, PatternLength, _, SubString),
   sub_string(Pattern, 0, _, _, SubString),
   Match = match(LineNumber, Index, SubString),
   NewIndex is Index + 1,
   searchPatternInLineCodes(LineCodes, Pattern, PatternLength, NewIndex, LineNumber, Result).
searchPatternInLineCodes(LineCodes, Pattern, PatternLength, Index, LineNumber, Result) :-
   NewIndex is Index + 1,
   searchPatternInLineCodes(LineCodes, Pattern, PatternLength, NewIndex, LineNumber, Result).

formatSearchResult([]) :-
   write("No se encontraron coincidencias.").
formatSearchResult([Match | Rest]) :-
   Match = match(Line, Index, SubString),
   formatMatch(Line, Index, SubString),
   formatSearchResult(Rest).

formatMatch(Line, Index, SubString) :-
   format("Coincidencia en línea ~w, posición ~w: ~s~n", [Line, Index, SubString]).


% RF19. systemViewTrash
% systemViewTrash/2: muestra el contenido de la papelera del sistema
% DOMINIO: System (estructura de filesystem), lspapelera (string)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna

systemViewTrash(System, Lspapelera) :-
   getTrashContent(System, Content),
   formatTrashContent(Content, Lspapelera).

getTrashContent(System, Content) :-
   getTrashPath(System, TrashPath),
   readTrashContent(TrashPath, Content).

getTrashPath(System, TrashPath) :-
   userData(System, UserData),
   userDataTrash(UserData, TrashPath).

readTrashContent(TrashPath, Content) :-
   open(TrashPath, read, Stream),
   read_string(Stream, _, Content),
   close(Stream).

formatTrashContent(Content, Lspapelera) :-
   split_string(Content, "\n", "\n", Lspapelera).


% RF20. systemRestore
% systemRestore/4: restaura un archivo o carpeta del sistema desde la papelera
% DOMINIO: System (estructura de filesystem), fileNameOrPath (string), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza xxxxxx para YYYYYYYY
% META SECUNDARIA: Ninguna

systemRestore(System, FileNameOrPath, UpdatedSystem) :-
   getTrashPath(System, TrashPath),
   restoreContent(TrashPath, FileNameOrPath, UpdatedSystem).

restoreContent(TrashPath, FileNameOrPath, UpdatedSystem) :-
   readTrashContent(TrashPath, Content),
   parseContent(Content, Items),
   restoreItems(Items, FileNameOrPath, UpdatedSystem).

parseContent(Content, Items) :-
   split_string(Content, "\n", "\n", Items).

restoreItems([], _, _).
restoreItems([Item|Items], FileNameOrPath, UpdatedSystem) :-
   restoreItem(Item, FileNameOrPath, UpdatedSystem),
   restoreItems(Items, FileNameOrPath, UpdatedSystem).

restoreItem(Item, FileNameOrPath, UpdatedSystem) :-
   split_string(Item, ",", ",", [Path, OriginalName]),
   (Path = FileNameOrPath ; OriginalName = FileNameOrPath),
   restoreFile(Path, OriginalName, UpdatedSystem).

restoreFile(Path, OriginalName, UpdatedSystem) :-
   userData(UpdatedSystem, UserData),
   userDataTrash(UserData, TrashPath),
   restoreFilePath(Path, TrashPath, RestoredPath),
   moveFile(TrashPath, RestoredPath),
   restoreItemData(UserData, Path, OriginalName).

restoreFilePath(Path, TrashPath, RestoredPath) :-
   sub_string(Path, 0, _, _, TrashPath),
   sub_string(Path, _, _, 0, FileName),
   atomic_list_concat([TrashPath, FileName], '/', RestoredPath).

moveFile(OldPath, NewPath) :-
   rename_file(OldPath, NewPath).

restoreItemData(UserData, Path, OriginalName) :-
   updateFileData(UserData, Path, OriginalName, UserData2),
   updateUserTrash(UserData2, UpdatedUserData),
   updateUserData(System, UpdatedUserData, UpdatedSystem).

updateFileData(UserData, Path, OriginalName, UpdatedUserData) :-
   getUserFiles(UserData, Files),
   restoreFileData(Files, Path, OriginalName, UpdatedFiles),
   setUserFiles(UserData, UpdatedFiles, UpdatedUserData).

restoreFileData([], _, _, []).
restoreFileData([File|Files], Path, OriginalName, [UpdatedFile|UpdatedFiles]) :-
   fileDataPath(File, FilePath),
   (FilePath = Path ->
       restoreFileName(File, OriginalName, UpdatedFile)
   ;
       UpdatedFile = File
   ),
   restoreFileData(Files, Path, OriginalName, UpdatedFiles).

restoreFileName(File, OriginalName, UpdatedFile) :-
   fileDataName(File, _),
   setFileDataName(File, OriginalName, UpdatedFile).

updateUserTrash(UserData, UpdatedUserData) :-
   setUserTrash(UserData, [], UpdatedUserData).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PRUEBAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
system("newSystem", S1),
systemAddDrive(S1, "C", "OS", 10000000000, S2),
systemRegister(S2, "user1", S3),
systemRegister(S3, "user2", S4),
systemLogin(S4, "user1", S5),
systemSwitchDrive(S5, "C", S6),
systemMkdir(S6, "folder1", S7),
systemMkdir(S7, "folder2", S8),
systemCd(S8, "folder1", S9),
systemMkdir(S9, "folder11", S10),
systemLogout(S10, S11),
systemLogin(S11, "user2", S12),
file("foo.txt", "hello world", F1),
systemAddFile(S12, F1, S13),
systemCd(S13, "/folder2", S14),
file("ejemplo.txt", "otro archivo", F2),
systemAddFile(S14, F2, S15).


systemFormat(S, "C", "newOS1", S2).
systemFormat(S, "D", "newOS2", S3).
systemFormat(S, "E", "newOS3", S4).

%systemDir(S, [], Str).
%systemDir(S, ["/s"], Str).

systemDel(S, "foo.txt", S1).
systemDel(S, "*.txt", S1).
systemDel(S, "f*.txt", S1).
systemDel(S, "*.*", S1).

*/