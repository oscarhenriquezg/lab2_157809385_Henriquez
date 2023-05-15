% TDA FS

% filesystem/5: Constructor de filesystem
% DOMINIO: Nombre (string), Drives (lista de drives), Users (lista de usuarios), Content (contenido), TimeStamp (marca de tiempo)
% META PRINCIPAL: Crear una estructura de filesystem con el timestamp dado
filesystem(Nombre, Drives, Users, Content, TimeStamp, [Nombre, Drives, Users, Content, TimeStamp]).

% getDrives/2: Obtiene los Drives de un System
% DOMINIO: System (estructura de filesystem), Drives (lista de drives)
% META PRINCIPAL: Retornar la lista de drives de un System
getDrives(System, Drives) :-
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
exists(Elemento, [_|RestoListas]) :-
   exists(Elemento, RestoListas).

% letterDoesntExistsInSystem/2: Verifica si una Unidad no existe en el System
% DOMINIO: Unidad (string), System (estructura de filesystem)
% META PRINCIPAL: Verificar que la Unidad no exista en los drives del System
letterDoesntExistsInSystem(Unidad, System) :-
   filesystem(_, Drives, _, _, _, System),
    \+ exists(Unidad, Drives).

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
  setAddUserInSystem(System, User, UpdatedSystem)
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
  member(User, Users). 

% TDA Drive

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

% RF1. constructor

% system/2: Constructor de sistema
% DOMINIO: Nombre (string), Sistema (estructura de filesystem)
% META PRINCIPAL: Utiliza filesystem/5 para crear un nuevo sistema con nombre “NewSystem”
% META SECUNDARIA: Ninguna
system(Nombre, Sistema) :-
  filesystem(Nombre, [], [], [], Sistema).

% RF2. addDrive

% systemAddDrive/5: Agrega un nuevo drive al sistema
% DOMINIO: System (estructura de filesystem), Unidad (string), Nombre (string), Capacidad (número), UpdatedSystem (estructura de filesystem actualizada)
% META PRINCIPAL: Utiliza letterDoesntExistsInSystem/2, drive/4, getDrives/2, setAddNewDriveInDrives/3 y setDrives/3 para agregar un nuevo drive al sistema
% META SECUNDARIA: Ninguna
systemAddDrive(System, Unidad, Nombre, Capacidad, UpdatedSystem) :-
  letterDoesntExistsInSystem(Unidad, System), 
  drive(Unidad, Nombre, Capacidad, NewDrive),
  getDrives(System, CurrentDrives),
  setAddNewDriveInDrives(NewDrive, CurrentDrives, UpdatedDrives),
  setDrives(System, UpdatedDrives, UpdatedSystem).

% RF 3. register
% system("NewSystem", S),
% systemRegister(S, "user1", S2).
% system("NewSystem", S),
% systemAddDrive(S, "C",  "OS", 10000000000, S2),
% systemRegister(S2, "user1", S3).

% systemRegister/3: Registra un nuevo usuario en el sistema
% DOMINIO: System (estructura de filesystem), User (string), UpdatedSystem (estructura de filesystem actual
% META PRINCIPAL: xxxxxxxxxx
% META SECUNDARIA: xxxxxxxx

systemRegister(System, User, UpdatedSystem) :-
  setAddUserInSystem(System, User, UpdatedSystem).



