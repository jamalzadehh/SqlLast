Create Database TaskArtist

Use TaskArtist

Create Table [Users](
[Id] Int Primary Key Identity,
[Name] Varchar(64) Not Null,
[Surname] Varchar(64) Default 'XXX',
[UserName]Varchar(64) Not Null,
[Password] Varchar(64) Not NUll,
[Gender] Varchar(8) Not Null
)

Create Table [Artist](
[Id] Int Primary Key Identity,
[Name] Varchar(64) Not Null,
[Surname] Varchar(64) Default 'XXX',
[Birthday] Varchar(10) Not Null,
[Gender] Varchar(8) Not Null
)

Create Table [Categories](
[Id] Int Primary Key Identity,
[Name] Varchar(64) Not Null,
)

Create Table [Musics](
[Id] Int Primary Key Identity,
[Name] Varchar(64) Not Null,
[Duration] Int,
[CategorieID] Int References [Categories](Id),
[ArtistId] Int References [Artist](Id)
)


Create Table [PlayList](
[UserId] Int References [Users](Id),
[MusicId] Int References [Musics](Id)
)


Insert [Users] Values
('Asiman','Qasimzada','AsamanBackDev','icki1122','Male'),
('Zulfiyya','Qurbanova','Zulu','pisik123','Male')

Insert [Artist] Values
('Shamama','Quliyeva','01.01.2004','Female'),
('Rashad','','04.03.2004','Male')

Insert [Categories] Values
('Naxcivan Milli Mahnisi'),
('Drill')

Insert [Musics] Values
('Naxcivanni qohumlarim hardadii', 180,1,1),
('Yeni 2023 xit by Rashaad', 159,2,2)

Insert [PlayList] Values
(1,1),
(2,2)

Create View [Details] 
As
Select 
    m.[Name] as 'Music Name',
    m.[Duration] as 'Duration',
    c.[Name] as 'Category',
    Concat(a.[Name],' ',a.[Surname]) as 'Artist'
From [Musics] m
Join [Categories] c ON m.[CategorieID] = c.[Id]
Join [Artist] a ON m.[ArtistId] = a.[Id]

Select*from Details

Create Procedure usp_CreateMusic 
@name Varchar(64), 
@duration Int, 
@catId Int, 
@artId Int
As
Begin
Insert Into Musics ([Name], [Duration], [CategorieID], [ArtistId])
Values (@name, @duration, @catId, @artId)
End

alter table musics add isdeleted bit default 0;

create trigger deletemusic
on musics
instead of delete
as
begin
    declare @id int;
    declare @isdeleted bit;

    select @id = id, @isdeleted = isdeleted from deleted;

    if @isdeleted = 0
    begin
        update musics set isdeleted = 1 where id = @id;
    end
    else
    begin
        delete from musics where id = @id;
    end
end;

create function getartistcountbyuser(@userid int)
returns int
as
begin
     declare @artistcount int;
     select @artistcount = count(distinct ArtistId) from playlist
     where userid = @userid;
     return @artistcount;
end;
 
-- Muellim 50 defef yazdim sildim.Ne qeder eledim bu errorlari aradan qaldira bilmedim.Hetta evvelki kodum bele islememeye basladi bir yerden sonra.















