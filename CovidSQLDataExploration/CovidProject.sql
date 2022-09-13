--Query CSV with all information
select *
 from master..AllDataSet 
 order by 3, 4 ;
 
 select count (*)  from master..AllDataSet;
 select count (*)  from master..AllDataSet(Bckp);


--Covid Vacc Table creation
select iso_code ,	continent ,	location ,	CONVERT(date,date,111) date,	convert(float, total_cases) total_cases,	convert(float, total_tests) total_tests,	convert(float, new_tests) new_tests,	
		convert(float, total_tests_per_thousand) total_tests_per_thousand,	convert(float, new_tests_per_thousand) new_tests_per_thousand,	convert(float, new_tests_smoothed) new_tests_smoothed,	
		convert(float, new_tests_smoothed_per_thousand) new_tests_smoothed_per_thousand,	convert(float, positive_rate) positive_rate,	convert(float, tests_per_case) tests_per_case,	tests_units,	
		convert(float, total_vaccinations) total_vaccinations,	convert(float, people_vaccinated) people_vaccinated,	convert(float, people_fully_vaccinated) people_fully_vaccinated,	convert(float, total_boosters) total_boosters,
		convert(float, new_vaccinations) new_vaccinations,	convert(float, new_vaccinations_smoothed) new_vaccinations_smoothed,	convert(float, total_vaccinations_per_hundred) total_vaccinations_per_hundred,	
		convert(float, people_vaccinated_per_hundred) people_vaccinated_per_hundred,	convert(float, people_fully_vaccinated_per_hundred) people_fully_vaccinated_per_hundred,	convert(float, total_boosters_per_hundred) total_boosters_per_hundred,	
		convert(float, new_vaccinations_smoothed_per_million) new_vaccinations_smoothed_per_million,	convert(float, new_people_vaccinated_smoothed) new_people_vaccinated_smoothed,	
		convert(float, new_people_vaccinated_smoothed_per_hundred) new_people_vaccinated_smoothed_per_hundred,	convert(float, stringency_index) stringency_index,	convert(float, population_density) population_density,
		convert(float, median_age) median_age,	convert(float, aged_65_older) aged_65_older,	convert(float, aged_70_older) aged_70_older,	convert(float, gdp_per_capita) gdp_per_capita,	
		convert(float, extreme_poverty) extreme_poverty,	convert(float, cardiovasc_death_rate) cardiovasc_death_rate,	convert(float, diabetes_prevalence) diabetes_prevalence,	convert(float, female_smokers) female_smokers,
		convert(float, male_smokers) male_smokers,	convert(float, handwashing_facilities) handwashing_facilities,	convert(float, hospital_beds_per_thousand) hospital_beds_per_thousand,	
		convert(float, life_expectancy) life_expectancy,	convert(float, human_development_index) human_development_index,	convert(float, excess_mortality_cumulative_absolute) excess_mortality_cumulative_absolute,	
		convert(float, excess_mortality_cumulative) excess_mortality_cumulative,	convert(float, excess_mortality) excess_mortality,	convert(float, excess_mortality_cumulative_per_million) excess_mortality_cumulative_per_million
	INTO CovidProject..CovidVaccinations from master..AllDataSet;

--Covid Death Table creation 
select iso_code,	continent,	location,	CONVERT(date,date,111) date,	convert(float, total_cases) total_cases,	convert(float, population) population,	convert(float, new_cases) new_cases,	
convert(float, new_cases_smoothed) new_cases_smoothed,	convert(float, total_deaths) total_deaths,	convert(float, new_deaths) new_deaths,	convert(float, new_deaths_smoothed) new_deaths_smoothed,	
convert(float, total_cases_per_million) total_cases_per_million,	convert(float, new_cases_per_million) new_cases_per_million,	convert(float, new_cases_smoothed_per_million) new_cases_smoothed_per_million,	
convert(float, total_deaths_per_million) total_deaths_per_million,	convert(float, new_deaths_per_million) new_deaths_per_million,	convert(float, new_deaths_smoothed_per_million) new_deaths_smoothed_per_million,	
convert(float, reproduction_rate) reproduction_rate,	convert(float, icu_patients) icu_patients,	convert(float, icu_patients_per_million) icu_patients_per_million,	convert(float, hosp_patients) hosp_patients,	
convert(float, hosp_patients_per_million) hosp_patients_per_million,	convert(float, weekly_icu_admissions) weekly_icu_admissions,	convert(float, weekly_icu_admissions_per_million) weekly_icu_admissions_per_million,	
convert(float, weekly_hosp_admissions) weekly_hosp_admissions,	convert(float, weekly_hosp_admissions_per_million) weekly_hosp_admissions_per_million
 INTO CovidProject..CovidDeaths  from master..AllDataSet;

--Check date format from source table
select distinct date from master..AllDataSet order by 1 ;

--Validate number of records inserted 
select count (*) from master..AllDataSet;              --214447
select count (*) from CovidProject..CovidDeaths;	   --214447
select count (*) from CovidProject..CovidVaccinations; --214447

--Query all data in the tables
 select * 
 from CovidProject..CovidDeaths
 order by 3, 4;

 select * 
 from CovidProject..CovidVaccinations
 order by 3, 4 

 --Select data to be used
 select location, date, total_cases, new_cases, a.total_deaths, population
 from CovidProject..CovidDeaths as a
 order by 1,2

 --Total cases Vs Total deaths
 -- Chances to die if ppl gets infected 
 select location, date, total_cases, total_deaths,  (total_deaths/total_cases)*100 as  DeathPercentage
 from CovidProject..CovidDeaths
 where total_cases <> 0 and location = 'Colombia'
 order by 2,1   asc;

 --Total cases Vs Population
 --Percentage of the pooulation with Covid
  select location, date, population, total_cases,  (total_cases/population)*100 as  CasesPercentage
 from CovidProject..CovidDeaths
 where population <> 0 and location = 'Colombia'
 order by 2,1   asc;

 --Highest infection rate compared to population
 select location, population, max(total_cases) HighestInfectionCount,  max((total_cases/population))*100 as  PercentagePopultaionInfected
	from CovidProject..CovidDeaths
	where population <> 0 
	group by location, population
 order by 4   desc;

 --Death count by country
  select location,  max(total_deaths) HighestDeathCount
	from CovidProject..CovidDeaths
	where continent <> ''
	group by location
  order by 2 desc;

 --Death count by continent
  select location,  max(total_deaths) HighestDeathCount
	from CovidProject..CovidDeaths
	where continent ='' and not iso_code like 'OWID_%C'
	group by location
  order by 2 desc;

  --Global numers by date 
   select date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases)*100 as death_percentage
	from CovidProject..CovidDeaths
	where new_cases<>0
	group by date
	order by 1;

  --CTE use
  with PopVsVacc as
  (
	  select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
		sum(cv.new_vaccinations) over (partition by cd.location order by cd.location, cd.date) as RollincCountPplVaccinated  --Count of ppl vaccinated  
	  from CovidProject..CovidDeaths cd
	  join CovidProject..CovidVaccinations cv
		ON cd.date =cv.date
		and cd.location= cv.location
	  where cd.continent <> ''
	  --order by 2,3
   )
   Select * , (RollincCountPplVaccinated/population)*100 as PercentageVaccinated
	from PopVsVacc
	where population<>0;

--Temp table use

DROP table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated  (
	continent	varchar(50), 
	location	varchar(50), 
	date		date, 
	population	float, 
	new_vaccinations float,
	RollincCountPplVaccinated float
)
insert into #PercentPopulationVaccinated
	select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
		sum(cv.new_vaccinations) over (partition by cd.location order by cd.location, cd.date) as RollincCountPplVaccinated  --Count of ppl vaccinated  
	  from CovidProject..CovidDeaths cd
	  join CovidProject..CovidVaccinations cv
		ON cd.date =cv.date
		and cd.location= cv.location
	  where cd.continent <> '';

select * from #PercentPopulationVaccinated;

--Creating View for later visualization 
Create view PercentPopulationVaccinated as 
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
		sum(cv.new_vaccinations) over (partition by cd.location order by cd.location, cd.date) as RollincCountPplVaccinated  --Count of ppl vaccinated  
	  from CovidProject..CovidDeaths cd
	  join CovidProject..CovidVaccinations cv
		ON cd.date =cv.date
		and cd.location= cv.location
	  where cd.continent <> '';

 --Death count by continent
Create view ContinentDeathCounth as 
  select location,  max(total_deaths) HighestDeathCount
	from CovidProject..CovidDeaths
	where continent ='' and not iso_code like 'OWID_%C'
	group by location;

