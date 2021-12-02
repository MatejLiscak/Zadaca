drop database if exists 1zadatak;
create database 1zadatak character set utf8;
use 1zadatak;

create table mladic(
    sifra int not null primary key auto_increment,
    suknja varchar(50) not null,
    kuna decimal(16,8) not null,
    drugiputa datetime not null,
    asocijalno boolean,
    ekstrovertno boolean not null,
    dukserica varchar(48) not null,
    muskarac int
);

create table svekar(
    sifra int not null primary key auto_increment,
    bojaociju varchar(40) not null,
    prstena int,
    dukserica varchar(41),
    lipa decimal(13,8),
    eura decimal(12,7),
    majica varchar(35)
);

create table muskarac(
    sifra int not null primary key auto_increment,
    bojaociju varchar(50) not null,
    hlace varchar(30),
    modelnaocala varchar(43),
    maraka decimal(14,5) not null,
    zena int not null
);

create table sestra(
    sifra int not null primary key auto_increment, 
    introvertno boolean,
    haljina varchar(31) not null,
    maraka decimal(16,6),
    hlace varchar(46) not null,
    narukvica int not null
);

create table sestra_svekar(
    sifra int not null primary key auto_increment, 
    sestra int not null,
    svekar int not null
);

create table zena(
    sifra int not null primary key auto_increment,
    treciputa datetime,
    hlace varchar(46),
    kratkamajica varchar(31) not null,
    jmbag varchar(11) not null,
    bojaociju varchar(39) not null,
    haljina varchar(44),
    sestra int not null
);

create table punac(
   sifra int not null primary key auto_increment,
   ogrlica int,
   gustoca decimal(14,9),
   hlace varchar(41) not null 
);

create table cura(
   sifra int not null primary key auto_increment,
   novcica decimal(16,5) not null,
   gustoca decimal(18,6) not null,
   lipa decimal(13,10),
   ogrlica int not null,
   bojakose varchar(38),
   suknja varchar(36),
   punac int 
);

alter table mladic add foreign key (muskarac) references muskarac(sifra);
alter table muskarac add foreign key (zena) references zena(sifra);
alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);
alter table zena add foreign key (sestra) references sestra(sifra);
alter table cura add foreign key (punac) references punac(sifra);

insert into sestra(sifra,haljina,hlace,narukvica)values
(null,'Ljetna haljina','Rifle',3),
(null,'Svećana haljina','Denim',2),
(null,'Elegantna haljina','Rifle',7);

insert into zena(sifra,kratkamajica,jmbag,bojaociju,sestra)values
(null,'Looney toons majica',13674859234,'Plava',1),
(null,'Addidas majica',98756745623,'Smeđa',3),
(null,'Nike majica',27384523451,'Plava',2);

insert into svekar(sifra,bojaociju)values
(null,'Plava'),
(null,'Smeđa'),
(null,'Zelena');

insert into sestra_svekar(sifra,sestra,svekar)values
(null,1,2),
(null,2,3),
(null,3,1);

update cura set gustoca=15.77;

delete from mladic where kuna>15.78;

select kratkamajica from zena where hlace like '%ana%';

select  f.dukserica,a.asocijalno,b.hlace
from a mladic 
inner join b muskarac on a.muskarac=b.sifra
inner join c zena on b.zena=c.sifra
inner join d sestra on c.sestra=d.sifra
inner join e sestra_svekar on d.sifra=e.sestra
inner join f svekar on e.svekar=f.sifra
where c.hlace like 'a%'and d.haljina like '%ba%' order by 3 desc;

select a.haljina,a.maraka
from sestra a
inner join sestra_svekar b on b.sestra=a.sifra where a.sifra not in (select sestra from sestra_svekar where sestra is not null);



