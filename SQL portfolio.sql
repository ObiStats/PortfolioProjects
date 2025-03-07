 -- Select Data that we are going to use

 SELECT Location, date, total_cases, new_cases, total_deaths, population
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is not null
 order by 1,2

 -- Exploring Total Cases vs Total Deaths

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is not null
 order by 1,2

 --Exploring Total Cases vs Population

 SELECT Location, date, total_cases, population, (total_cases/population)*100 as PopulationDeathPercentage
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is not null
 order by 1,2

--Exploring countries with highest infection rate compared to population

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_deaths/total_cases))*100 as PopulationDeathPercentage
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is not null
 group by location, population
 order by PopulationDeathPercentage desc 

 --Exploring countries with highest death count per population

SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is not null
 group by location
 order by TotalDeathCount desc 

-- Exploring data by continent

SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is null
 group by location
 order by TotalDeathCount desc 

--Exploring global data

SELECT date, SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
 FROM `portfolio-project-452918.Deaths.CovidDeaths`
 Where continent is not null
 group by date
 order by 1,2

--Exploring Total Population vs vaccinations

 SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations
 , SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER by dea.location,dea.date) as RollingVaccinatedCount
 FROM `portfolio-project-452918.Deaths.CovidDeaths` dea
 Join `portfolio-project-452918.Deaths.CovidVaccinations` vac
      on dea.location = vac.location
      and dea.date = vac.date
where dea.continent is not null
order by 2,3

--USE CTE

With PopvsVac(Continent, Location, Date, Population, New_Vaccinations, RollingVaccinatedCount)
as
(
 SELECT dea.continent,dea.location,dea.date, dea.population, vac.new_vaccinations
 , SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.location ORDER by dea.location,dea.date) as RollingVaccinatedCount
 FROM `portfolio-project-452918.Deaths.CovidDeaths` dea
 Join `portfolio-project-452918.Deaths.CovidVaccinations` vac
      on dea.location = vac.location
      and dea.date = vac.date
where dea.continent is not null
)
Select *
From PopvsVac
