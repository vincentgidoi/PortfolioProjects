 Select *
 From CovidDeaths

 -- Select *
 --From CovidVaccinations



 Select Location, date, total_cases, new_cases, total_deaths, population
 From CovidDeaths
 Order by 1,2

---- Looking at Toal Cases vs Total Deaths
-----Shows Likelihood of dying if you contract Covid 19 in Keya

 Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
 From CovidDeaths
 Where Location = 'Kenya'
 Order by 1,2


 ----Looking at the Total Cases vs Population
  Select Location, date, population, total_cases, (total_cases/population)*100 as CasePercentage
 From CovidDeaths
 -----Where Location = 'Kenya'
 Order by 1,2


 ---Countries with Highest Infection Rate Comapred to Population 

   Select Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 as CasePercentage
 From CovidDeaths
 -----Where Location = 'Kenya'
 Group by Location, population
 Order by CasePercentage desc

 ---Showing Countries with Highest Death Count per Population

    Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
	From CovidDeaths
 Where continent is not null
 Group by Location
 Order by TotalDeathCount desc


---- Continents With Highest Death Counts

  Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
	From CovidDeaths
 Where continent is not null
 Group by continent
 Order by TotalDeathCount desc

 --Looking at Total Population vs Vaccinations

 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 ,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location
 ,dea.date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/population)*100
 From CovidDeaths dea
 Join CovidVaccinations vac
	On dea.Location = dea.Location
	and dea.date = dea.date
Where dea.continent is not null
order by 2,3

--USE CTE

With PopvsVac (Continent, location, Date, Population, New_Vaccinations, RollingPeopleVaccinated )
as
(
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
 , SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location
 ,dea.date) as RollingPeopleVaccinated
-- ,(RollingPeopleVaccinated/Population)*100
 From CovidDeaths dea
 Join CovidVaccinations vac
	On dea.Location = vac.Location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac












Insert into


