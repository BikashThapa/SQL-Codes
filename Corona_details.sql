
use portfolioproject;
-- looking at Total Death vs Total Caes
-- likelihood of dying if you get corona-virus in a country

select location,date,total_cases,new_cases,total_deaths,(total_deaths/total_cases) * 100 as DeathPercentage
from covid_data 
where (location="Nepal" or location  like '%states%' ) order by location;

-- looking at Total Population vs Total Deaths
-- Shows % of populations that got covid
select location,date,total_cases,new_cases,population,(total_cases/population) * 100 as InfectionPercentage
from covid_data 
where (location="Nepal" or location  like '%states%' ) order by location;

-- looking at countries with highest infection rate in total population
select location,population,max(total_cases) as Highest_Infection_count ,max((total_cases/population))* 100 as InfectionPercentage
from covid_data 
group by location,population
order by InfectionPercentage desc;

-- looking at Countries with Highest Death Count in total poulation

select location, max(cast(total_deaths as unsigned)) as TotalDeathCount -- total_deaths is in text format so chnaged in int format
from covid_data 
where continent is not null
group by location
order by TotalDeathCount desc;

-- Breaking Down Continent Section

select continent, max(cast(total_deaths as unsigned)) as TotalDeathCount -- total_deaths is in text format so chnaged in int format
from covid_data 
where continent is not null
group by continent
order by TotalDeathCount desc;

-- daily new cases and deaths
select date,sum(new_cases),sum(cast(new_deaths as unsigned)) as TotalDeaths, sum(cast(new_deaths as unsigned))/sum(new_cases) * 100 as DeathPercentage
from covid_data
where continent is not null
group by date
order by date;

-- looking at total population vs vaccination
with vaccination (continent,location,date,population,new_vaccinations,vaccinationovertime)
as
(
select cd.continent,cd.location ,cd.date,cd.population, cv.new_vaccinations,sum(cast(new_vaccinations as unsigned)) over (partition by cd.location order by cd.location,cd.date) as TotalVaccinationOverTime
 from covid_data cd 
join covidvaccinations cv 
using(location,date)
where cd.continent is not null 
order by 2,3)
select *,(vaccinationovertime/population ) * 100 
from vaccination;

 -- Create View 
 create view PercentPopulationVaccinated as 
select cd.continent,cd.location ,cd.date,cd.population, cv.new_vaccinations,sum(cast(new_vaccinations as unsigned)) over (partition by cd.location order by cd.location,cd.date) as TotalVaccinationOverTime
 from covid_data cd 
join covidvaccinations cv 
using(location,date)
where cd.continent is not null 
order by 2,3;







