@echo off
setlocal enabledelayedexpansion
color f9
title TBDC(Text Based Dungeon Crawler)
mode con cols=1000 lines=32766
call set PossibleEnemies.Name.0=Goblin
call set PossibleEnemies.Name.1=Zombie
call set PossibleEnemies.Name.2=Skeleton
call set PossibleEnemies.Name.3=Orc
call set PossibleEnemies.Name.4=Acrobat

call set PossibleEnemies.Damage.0=5
call set PossibleEnemies.Damage.1=3
call set PossibleEnemies.Damage.2=3
call set PossibleEnemies.Damage.3=7
call set PossibleEnemies.Damage.4=4

call set PossibleEnemies.Health.0=20
call set PossibleEnemies.Health.1=15
call set PossibleEnemies.Health.2=11
call set PossibleEnemies.Health.3=25
call set PossibleEnemies.Health.4=15

call set PossibleEnemies.Dodge.0=7
call set PossibleEnemies.Dodge.1=3
call set PossibleEnemies.Dodge.2=10
call set PossibleEnemies.Dodge.3=0
call set PossibleEnemies.Dodge.4=80

call set PossibleClass.Class.0=Knight
call set PossibleClass.Class.1=Archer
call set PossibleClass.Class.2=Bozo
call set PossibleClass.Class.3=Mage
call set PossibleClass.Class.4=Tank

call set PossibleClass.Damage.0=15
call set PossibleClass.Damage.1=3
call set PossibleClass.Damage.2=20
call set PossibleClass.Damage.3=12
call set PossibleClass.Damage.4=7

call set PossibleClass.Health.0=20
call set PossibleClass.Health.1=3
call set PossibleClass.Health.2=-10
call set PossibleClass.Health.3=7
call set PossibleClass.Health.4=50

call set PossibleClass.CritHitChance.0=0
call set PossibleClass.CritHitChance.1=10
call set PossibleClass.CritHitChance.2=70
call set PossibleClass.CritHitChance.3=21
call set PossibleClass.CritHitChance.4=5

set PossibleClass.Ability.0=Parry
set PossibleClass.Ability.1=Arrowstorm
set PossibleClass.Ability.2=The Power Of im_a_squid_kid's WRATH
set PossibleClass.Ability.3=Lightning
set PossibleClass.Ability.4=Reinforced Armour

set AbilityCharge.max4.0={null    }
set AbilityCharge.max4.1={[]      }
set AbilityCharge.max4.2={[][]    }
set AbilityCharge.max4.3={[][][]  }
set AbilityCharge.max4.4={[][][][]}
set AbilityCharge.max3.0={null  }
set AbilityCharge.max3.1={[]    }
set AbilityCharge.max3.2={[][]  }
set AbilityCharge.max3.3={[][][]}
set AbilityCharge.max2.0={null}
set AbilityCharge.max2.1={[]  }
set AbilityCharge.max2.2={[][]}


set PossiblePowerUps.0=Increased Maximum Health(No Heal)  
set PossiblePowerUps.1=Increased Critical Hit Chance  
set PossiblePowerUps.2=Increased Damage  
set PossiblePowerUps.3=Absorption(+20 Health, Adds Even If You Are At Full Health)  
set PossiblePowerUps.4=1 Percent Chance To Insta-Kill  
set PossiblePowerUps.5=Rename Your Character  
set PossiblePowerUps.6=Heal to Full Heal(If You Choose To Heal It Will Full Heal You)
set PossiblePowerUps.7=+1 Charge of Your Ability(Will not Bypass Limit)

set Player.FullHeal=False
set Player.FullHeal.Name=Sets Your Current Damage Taken to Zero(Heals you by %Player.DamageTaken%)

set /a Player.Round=0
set /p User=What Is Your Username? 
echo Hello %User%
set /p begin=New Game?(Y/N) 
if %begin% equ Y goto Class
if exist "Saves\Save%User%Player.dat" set /p begin=Continue?(Y/N)
if exist "Saves\Save%User%Player.dat" if %begin% equ Y for /f "delims=" %%a in (Saves\Save%User%Player.dat) do set "%%a"
if exist "Saves\Save%User%Player.dat" if %begin% equ Y for /f "delims=" %%b in (Saves\Save%User%Enemy.dat) do set "%%b"
if exist "Saves\Save%User%Player.dat" if %begin% equ Y goto Game
if %begin% equ Y goto Class
exit

:Class
echo What Class Would You Like %User%?(type in the number NOT the name)
echo 0. Knight
echo 1. Archer
echo 2. Bozo
echo 3. Mage
echo 4. Tank
echo .
echo .
echo .
echo .
set /p Class=.
echo You are a !PossibleClass.Class.%Class%!
goto difficulty

:difficulty
set /p difficulty=Choose Difficulty(Easy,Medium,Hard)
if %difficulty% equ Easy goto EasySetUp
if %difficulty% equ Medium goto MediumSetUp
if %difficulty% equ Hard goto HardSetUp
echo make sure to spell it right this time and capitolize!
goto difficulty

:EasySetUp
set Player.Class=!PossibleClass.Class.%Class%!
set /a Player.ClassNum=%Class%
set /a Player.MaxHealth=100+!PossibleClass.Health.%Class%!
set /a Player.Health=%Player.MaxHealth%
set /a Player.DamageTaken=0
set /a Player.Damage=!PossibleClass.Damage.%Class%!
set /a Player.CritHitChance=20+!PossibleClass.CritHitChance.%Class%!
set /a Player.Offset=1
set Player.Ability=!PossibleClass.Ability.%Class%!
set Player.AbilityChargesMaximum=max4
set /a Player.AbilityChargesLeft=4
goto EnemySetup1

:MediumSetUp
set Player.Class=!PossibleClass.Class.%Class%!
set /a Player.ClassNum=%Class%
set /a Player.MaxHealth=70+!PossibleClass.Health.%Class%!
set /a Player.Health=%Player.MaxHealth%
set /a Player.DamageTaken=0
set /a Player.Damage=!PossibleClass.Damage.%Class%!
set /a Player.CritHitChance=32+!PossibleClass.CritHitChance.%Class%!
set /a Player.Offset=1
set Player.Ability=!PossibleClass.Ability.%Class%!
set Player.AbilityChargesMaximum=max3
set /a Player.AbilityChargesLeft=3
goto EnemySetup1

:HardSetUp
set Player.Class=!PossibleClass.Class.%Class%!
set /a Player.ClassNum=%Class%
set /a Player.MaxHealth=50+!PossibleClass.Health.%Class%!
set /a Player.Health=%Player.MaxHealth%
set /a Player.DamageTaken=0
set /a Player.Damage=!PossibleClass.Damage.%Class%!
set /a Player.CritHitChance=1+!PossibleClass.CritHitChance.%Class%!
set /a Player.Offset=2
set Player.Ability=!PossibleClass.Ability.%Class%!
set Player.AbilityChargesMaximum=max2
set /a Player.AbilityChargesLeft=2
goto EnemySetup1

:EnemySetup1
set /a Player.Round=%Player.Round%+1
set /a Enemy1.Num=%random% %%5
set /a Enemy2.Num=%random% %%5
goto EnemySetup2

:EnemySetup2
call set /a Enemy1.MaximumHealth=%Player.Round%/2*!PossibleEnemies.Health.%Enemy1.Num%!*%Player.Offset%
call set /a Enemy2.MaximumHealth=%Player.Round%/2*!PossibleEnemies.Health.%Enemy2.Num%!*%Player.Offset%
call set /a Enemy1.Health=%Player.Round%/2*!PossibleEnemies.Health.%Enemy1.Num%!*%Player.Offset%
call set /a Enemy2.Health=%Player.Round%/2*!PossibleEnemies.Health.%Enemy2.Num%!*%Player.Offset%
call set /a Enemy1.Damage=%Player.Round%/2*!PossibleEnemies.Damage.%Enemy1.Num%!*%Player.Offset%
call set /a Enemy2.Damage=%Player.Round%/2*!PossibleEnemies.Damage.%Enemy2.Num%!*%Player.Offset%
call set /a Enemy1.Dodge=!PossibleEnemies.Dodge.%Enemy1.Num%!*%Player.Offset%
call set /a Enemy2.Dodge=101
call set Enemy1.Name=!PossibleEnemies.Name.%Enemy1.Num%!
call set Enemy2.Name=!PossibleEnemies.Name.%Enemy2.Num%!
goto Game

:Game
set Player>"Saves\Save%User%Player.dat"
set Enemy>"Saves\Save%User%Enemy.dat"
set /a Enemy1.Dodged=%random% %%100
set /a Enemy2.Dodged=%random% %%100
set /a Player.Health=Player.Health-Player.DamageTaken
if %Enemy1.Dodged% leq 0 set Enemy1.Dodged=True
if %Enemy2.Dodged% leq 0 set Enemy2.Dodged=True
if %Enemy1.Dodged% neq True set Enemy1.Dodged=False
if %Enemy2.Dodged% neq True set Enemy2.Dodged=False
if %Player.Health% leq 0 goto DeathScreen
set /a Player.DamageTaken=0
echo [%Player.Class%]%User%  Health = !Player.Health!/!Player.MaxHealth!   Damage:%Player.Damage%    Critical Hit Chance 1 in %Player.CritHitChance%              Round:%Player.Round%
echo .
echo .
echo .
echo .
echo The first enemy you see is a !Enemy1.Name!    !Enemy1.Health!/!Enemy1.MaximumHealth!                   The second enemy you see is a !Enemy2.Name!    !Enemy2.Health!/!Enemy2.MaximumHealth!
echo .
echo .
echo .
echo .
echo .
echo .
if %Enemy1.Health% geq 1 if %Enemy2.Health% geq 1 set /a Attacker=%random% %%2 +1
if %Enemy1.Health% geq 1 if %Enemy2.Health% lss 1 set /a Attacker=1
if %Enemy1.Health% lss 1 if %Enemy2.Health% geq 1 set /a Attacker=2
set /p Player.AttackType=Attack or use %Player.Ability%, Charges:!AbilityCharge.%Player.AbilityChargesMaximum%.%Player.AbilityChargesLeft%!(1 or 2)   
if %Player.AttackType% equ 1 goto NormalAttack
if %Player.AbilityChargesLeft% gtr 0 goto AbilityAttack
echo LMAO you have no more charges left^^!
goto FailedAbility

:NormalAttack
set /p Player.Attack=Which Enemy Do You Attack?(1/2)
set /a IsCritical=%Random% %%100
set IsCritical=%IsCritical%-%Player.CritHitChance%
if %IsCritical% gtr 0 if !Enemy%Player.Attack%.Dodged! equ False set /a Enemy%Player.Attack%.Health=!Enemy%Player.Attack%.Health!-%Player.Damage%
if %IsCritical% leq 0 if !Enemy%Player.Attack%.Dodged! equ False !Enemy%Player.Attack%.Dodge! set /a Enemy%Player.Attack%.Health=!Enemy%Player.Attack%.Health!-%Player.Damage%*2
if %IsCritical% leq 0 if !Enemy%Player.Attack%.Dodged! equ False !Enemy%Player.Attack%.Dodge! echo Critical Hit^^!
if !Enemy%Player.Attack%.Dodged! equ True echo !Enemy%Player.Attack%.Name! dodged^^!
set /a Player.DamageTaken=!Enemy%Attacker%.Damage!
echo !Enemy%Attacker%.Name! has attacked dealing !Enemy%Attacker%.Damage! damage^^!
goto EndOfGame

:FailedAbility
set /a Player.DamageTaken=!Enemy%Attacker%.Damage!
echo !Enemy%Attacker%.Name! has attacked dealing !Enemy%Attacker%.Damage! damage^^!
goto EndOfGame

:AbilityAttack
set /a Player.AbilityChargesLeft=%Player.AbilityChargesLeft%-1
echo [%Player.Class%]%User% used %Player.Ability%
goto Ability.%Player.ClassNum%

:Ability.0
set /a Player.Health=%Player.Health%+10
set /a Enemy%Attacker%.Health=!Enemy%Attacker%.Health!-!Enemy%Attacker%.Damage!
echo You Successfully Parried the !Enemy%Attacker%.Name!'s Attack^^!
goto EndOfGame

:Ability.1
set /a HitsOnEnemy1=%random% %%3 +1
set /a HitsOnEnemy2=%random% %%3 +1
set /a Enemy1.Health=%Enemy1.Health%-5*%HitsOnEnemy1%
set /a Enemy2.Health=%Enemy2.Health%-5*%HitsOnEnemy2%
echo the Enemies were terrified by the rain of arrows^^!
goto EndOfGame

:Ability.2
set /a Player.Attack=%random% %%2 +1
set /a Enemy%Player.Attack%.Health=!Enemy%Player.Attack%.Health!-%Player.Damage%*5
echo You Went so Berserk on That First Enemy That The Other Ones Mind Became a Bit Mushy^^!
goto EndOfGame

:Ability.3
set /p Player.Attack=Which Enemy do You Focus on?(1/2)
set /a Enemy1.Health=%Enemy1.Health%-7
set /a Enemy2.Health=%Enemy2.Health%-7
set /a Enemy%Player.Attack%.Health=!Enemy%Player.Attack%.Health!-5
echo You Litterally Stunned Them With Your Spectacular Power^^!
goto EndOfGame

:Ability.4
set /a Player.Health=%Player.MaxHealth%+30
echo The Enemies Decided To Let You Fix Your Armour In Peace ^^^-^^
^
goto EndOfGame

:EndOfGame
if %Enemy1.Health% leq 0 if %Enemy2.Health% leq 0 goto PowerUpSetup
if %Enemy1.Health% geq 0 if %Enemy2.Health% geq 0 if %Player.Health%-%Player.DamageTaken% geq 1 goto Game
if %Enemy1.Health% leq 0 if %Enemy2.Health% geq 1 if %Player.Health%-%Player.DamageTaken% geq 1 goto Game
if %Enemy1.Health% geq 1 if %Enemy2.Health% leq 0 if %Player.Health%-%Player.DamageTaken% geq 1 goto Game

:DeathScreen
set /p Restart=Game Over, Restart?(Y/N)  
if Restart equ Y goto Restart
if Restart neq Y exit

:Restart
start
exit 

:PowerUpSetup
set /a Powerup.1=%random% %%7
set /a Powerup.2=%random% %%7
set Powerup.Name.1= !PossiblePowerUps.%Powerup.1%!
set Powerup.Name.2= !PossiblePowerUps.%Powerup.2%!
echo Congratulations, You defeated a Round!
set /p Choice=Would you like a Powerup(two choices will be presented), or a Heal(no damage taken from the last attack)?(1 or 2)  
if %Choice% equ 1 set /p ChosenPowerup=Choose Your Powerup,    (1)%Powerup.Name.1%           (2)%Powerup.Name.2%
if %Choice% equ 1 set ChosenPowerup=!Powerup.%ChosenPowerup%!
if %Choice% equ 1 goto Powerup.%ChosenPowerup%
if %Choice% equ 2 if %Player.FullHeal% neq True set /a Player.DamageTaken=0
if %Choice% equ 2 if %Player.FullHeal% equ True set /a Player.Health=%Player.MaxHealth%
if %Choice% equ 2 if %Player.FullHeal% equ False goto EnemySetup1
if %Choice% equ 2 set Player.FullHeal.Name=Heals You To Full
if %Choice% equ 2 goto EnemySetup1

:Powerup.0
set /a Player.MaxHealth=%Player.MaxHealth%+10
goto EnemySetup1

:Powerup.1
set /a Player.CritHitChance=%Player.CritHitChance%+5
goto EnemySetup1

:Powerup.2
set /a Player.Damage=%Player.Damage%+%Player.Damage%/2
goto EnemySetup1

:Powerup.3
set /a Player.Health=%Player.Health%+20
goto EnemySetup1

:Powerup.4
set /a Player.InstakillChance=1
goto EnemySetup1

:Powerup.5
set /p User=You May Rename Your Character, Please Do So,    
goto EnemySetup1

:Powerup.6
set Player.FullHeal=True
goto EnemySetup1
