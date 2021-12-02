drop database if exists 2zadatak;
create database 2zadatak character set utf8;
use 2zadatak;

create table neprijatelj(
    sifra int not null primary key auto_increment,
    majica varchar(32),
    haljina varchar(43) not null,
    lipa decimal(16,8),
    modelnaocala varchar(49) not null,
    kuna decimal(12,6) not null,
    jmbag char(11),
    cura int
);

create table brat(
    sifra int not null primary key auto_increment,
    suknja varchar(47),
    ogrlica int not null,
    asocijalno boolean not null,
    neprijatelj int not null
);

create table zarucnica(
    sifra int not null primary key auto_increment,
    narukvica int,
    bojakose varchar(37) not null,
    novcica decimal(15,9),
    lipa decimal (15,8) not null,
    indiferentno boolean not null
);

create table decko(
    sifra int not null primary key auto_increment,
    indiferentno boolean,
    vesta varchar(34),
    asocijalno boolean not null
);

create table decko_zarucnica(
    sifra int not null primary key auto_increment,
    decko int not null,
    zarucnica int not null
);

create table cura(
    sifra int not null primary key auto_increment,
    haljina varchar(33) not null,
    drugiputa datetime not null,
    suknja varchar(38),
    narukvica int,
    introvertno boolean,
    majica varchar(40) not null,
    decko int
);

create table svekar(
    sifra int not null primary key auto_increment,
    stillfrizura varchar(48),
    ogrlica int not null,
    asocijalno boolean not null
);

create table prijatelj(
    sifra int not null primary key auto_increment,
    modelnaocala varchar(37),
    treciputa datetime not null,
    ekstrovertno boolean not null,
    prviputa datetime,
    svekar int not null
);

alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);
alter table cura add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);
alter table neprijatelj add foreign key (cura) references cura(sifra);
alter table prijatelj add foreign key (svekar) references svekar(sifra);

insert into cura(sifra,haljina,drugiputa,majica)values
(null,'Ljetna haljina',1999-29-01,'Adidas majica'),
(null,'Ljetna haljina',2001-01-09,'Puma majica'),
(null,'Svećana haljina',2003-09-07,'Nike majica');

insert into neprijatelj(sifra,haljina,modelnaocala,kuna)values
(null,'Ljetna haljina','Rayban',13000.12),
(null,'Ljetna haljina','Vision',9800.98),
(null,'Elegantna haljina','Rayban',78900.13);

insert into decko(sifra,asocijalno)values
(1,true),
(2,false),
(3,false);

insert into zarucnica(sifra,bojakose,lipa,indiferentno)values
(null,'Plava',12,false),
(null,'Plava',98,true),
(null,'Crna',13,true);

insert into decko_zarucnica(sifra,decko,zarucnica)values
(null,1,1),
(null,2,2),
(null,3,3);

update prijatelj set treciputa=2020-30-04;

delete from brat where ogrlica !=14;

select suknja from cura where drugiputa is null;

select c.novcica, f.neprijatelj, e.haljina
from decko a 
inner join decko_zarucnica b on a.sifra = b.decko
inner join zarucnica c on c.sifra = b.zarucnica
inner join cura d on a.sifra = d.decko
inner join neprijatelj e on e.cura = d.sifra
inner join brat f on f.neprijatelj = e.sifra
where d.drugiputa is not null and a.vesta like '%ba%' order by e.haljina desc;

select a.vesta,a.asocijalno 
from decko a 
inner join decko_zarucnica b on b.decko=a.sifra 
where a.sifra not in (select decko from decko_zarucnica where decko is not null);