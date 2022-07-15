  /*CovidDeaths*/


 Select *
 from Github_Project..CovidDeaths
 where continent is not null
 order by 3,4

 --Select *
 --from Github_Project..CovidVaccinations
 --order by 3,4

 --Select data that we are going to be using

 Select location, date, total_cases, new_cases, total_deaths, population
 from Github_Project..CovidDeaths
 order by 1,2


 -- Looking at Total Cases vs Total Deaths

 Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 from Github_Project..CovidDeaths
 where location like '%States%'
 order by 1,2


 --Looking at Total Cases vs Population
 --Shows waht % of population was down with Covid

 Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
 from Github_Project..CovidDeaths
 where location like '%States%'
 order by 1,2


 --Looking at Countries with highest Infection Rate compared to Population

 Select location,Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
 from Github_Project..CovidDeaths
 Group by Location,Population
 Having Max(total_cases)>50000
 Order by 1,2


 --Looking at Countries with highest death rate compared to population

 Select location,Population, Max(cast(total_deaths as int)) TotalDeathCount
 from Github_Project..CovidDeaths
 where continent is not null
 Group by Location,Population
 Order by TotalDeathCount desc


 -- Let's break things down by Continent  
 --Showing continents with the highest death count per population

 Select continent, Max(cast(total_deaths as int)) TotalDeathCount
 from Github_Project..CovidDeaths
 where continent is not null
 Group by continent
 Order by TotalDeathCount desc


 --Global Numbers

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from Github_Project..CovidDeaths
where continent is not null
Order by 1,2


/*Covid Vaccinations*/

--Looking at total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location, dea.date) as RollingPeopleVaccinated
from Github_Project..CovidDeaths dea
inner join Github_Project..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
Order by continent,location,date


