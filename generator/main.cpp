#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include <vector>
using namespace std;

class ConfDate {
    int day, month, year;

public: ConfDate()
    {
        day = 21;
        month = 1;
        year = 2017;
    }



    void nextConf()
    {
        if (day < 15)
        {
            day = rand() % 13 + 15;
        } else
        {
            day = rand() % 12;
            if (day == 0)
                day ++;
            month++;
            if (month == 13 )
            {
                month = 1;
                year++;
            }
        }

    }

    string getLastDayDate()
    {
        if (day < 15) {
            string result = "\'";
            result += to_string(year) + '-';
            if (month < 10)
                result += '0';
            result += to_string(month) + '-';
            if (day < 10)
                result += '0';
            result += to_string(day + 1);
            result += '\'';
            return result;
        }
        else
        {
            string result = "\'";
            result += to_string(year) + '-';
            if (month < 10)
                result += '0';
            result += to_string(month) + '-';
            if (day < 10)
                result += '0';
            result += to_string(day + 2);
            result += '\'';
            return result;
        }
    }

    string getFirstDayDate()
    {
        string result = "\'";
        result += to_string(year) + '-';
        if (month < 10)
            result += '0';
        result += to_string(month) + '-';
        if (day < 10)
            result += '0';
        result += to_string(day);
        result += '\'';
        return result;
    }
};

void generateConferences() {
    fstream file;
    file.open("/home/adios/CLionProjects/untitled1/ConferencesOld.txt");
    fstream output;
    output.open("/home/adios/CLionProjects/untitled1/ConferencesGenerated.sql", ios::out);
    if (file.good() == true)
        cout << "Otwarto plik" << endl;
    else
    {
        cout << "Nie otwarto pliku, zakoncz program" << endl;
        return;
    }

    ConfDate date;
    cout << date.getFirstDayDate() + ',' + date.getLastDayDate() << endl;

    string line;

    while (getline(file, line))
    {
        string newline;
        int i = 0;
        while (i < line.length())
        {
            while (line[i] != '\'' || !isdigit(line[i+1])){
                if (i >= line.length())
                    break;
                newline += line[i];
                i++;
            }
            if (i >= line.length())
                break;
            newline += date.getFirstDayDate() + "," + date.getLastDayDate();
            i+=21;
            date.nextConf();

        }
        output << newline << endl;

    }
}

void generateWorkshops() {
    fstream output;
    output.open("/home/adios/CLionProjects/untitled1/WorkshopsGenerated.txt", ios::out);

    vector<string> workshopNames;
    workshopNames.push_back("Jak zyc?");
    workshopNames.push_back("Wegiel - zabojca czlowieka");
    workshopNames.push_back("Smieci");
    workshopNames.push_back("Daleko jeszcze?");
    workshopNames.push_back("Ciezkie zycie studenta");
    workshopNames.push_back("Analogie miedzy spoleczenstwami");
    workshopNames.push_back("Jakie auto do 10 000?");
    workshopNames.push_back("Tanie elektryki");
    workshopNames.push_back("Daj wiecej");
    workshopNames.push_back("Ciekawa nazwa warsztatu 1");
    workshopNames.push_back("Ciekawa nazwa warsztatu 2");

    cout << "Workshops input range" << endl;
    int first, last;
    cin >> first >> last;

    const string templat = "EXEC dbo.addWorkshop ";

    for (int i = first; i <= last; i++)
    {
        string result = templat + to_string(i) + ", \'" + workshopNames[ rand() % workshopNames.size() ] + "\', \'09:15:00\', \'10:30:00\', 40, 20" ;
        output << result << endl;
        result = templat + to_string(i) + ", \'" + workshopNames[ rand() % workshopNames.size() ] + "\', \'11:30:00\', \'13:00:00\', 50, 40" ;
        output << result << endl;
        result = templat + to_string(i) + ", \'" + workshopNames[ rand() % workshopNames.size() ] + "\', \'14:00:00\', \'15:30:00\', 100, 600" ;
        output << result << endl;
        result = templat + to_string(i) + ", \'" + workshopNames[ rand() % workshopNames.size() ] + "\', \'16:30:00\', \'18:00:00\', 20, 50" ;
        output << result << endl;

    }

}

string getRandomDigits(int x)
{
    string result;
    for (int i = 0; i < x; i++)
    {
        result += to_string(rand() % 10);
    }
    return result;
}
void generateParticipants()
{
    fstream output;
    output.open("/home/adios/CLionProjects/untitled1/ParticipantsGenerated.txt", ios::out);

    vector<string> participantFirstNames;
    participantFirstNames.push_back("Adrian");
    participantFirstNames.push_back("Dawid");
    participantFirstNames.push_back("Mateusz");
    participantFirstNames.push_back("Krzysztof");
    participantFirstNames.push_back("Maxymilian");
    participantFirstNames.push_back("Joanna");
    participantFirstNames.push_back("Adrianna");
    participantFirstNames.push_back("Agnieszka");
    participantFirstNames.push_back("Martyna");
    participantFirstNames.push_back("Kinga");

    vector<string> participantSurname;
    participantSurname.push_back("Kowalski");
    participantSurname.push_back("Nowak");
    participantSurname.push_back("Głowacki");
    participantSurname.push_back("Konstantynopolitanczykiewicz");
    participantSurname.push_back("Soplica");
    participantSurname.push_back("Twardowski");
    participantSurname.push_back("Kochanowski");
    participantSurname.push_back("Burnside");
    participantSurname.push_back("Newton");
    participantSurname.push_back("Einstein");


    const string templat = "EXEC dbo.addParticipant ";

    for (int i = 0; i <= 800; i++)
    {
        string name = participantFirstNames[rand() % participantFirstNames.size()];
        string surname = participantSurname[rand() % participantSurname.size()];
        string result = templat + "\'" + name + "\', \'" + surname
                + "\', \'" + getRandomDigits(9) + "\', \'" + name+surname+getRandomDigits(2)+"@onte.pl\', null";
        output << result << endl;
    }

    for (int i = 0; i <= 200; i++)
    {
        string name = participantFirstNames[rand() % participantFirstNames.size()];
        string surname = participantSurname[rand() % participantSurname.size()];
        string result = templat + "\'" + name + "\', \'" + surname
                        + "\', \'" + getRandomDigits(9) + "\', \'" + name+surname+getRandomDigits(2)+"@onte.pl\', \'"
                        + getRandomDigits(6) + "\'";
        output << result << endl;
    }
}

int getRandomClientID() {
    int clientsStart1 = 1, clientsEnd1 = 400, clientsStart2 = 701, clientsEnd2 = 800;
    int x = rand() % 500;
    if ( x > clientsEnd1 )
        x = x + clientsStart2 - clientsEnd1;
    if (x == 0)
        x = 1;
    return  x;
}

string getRandomDate()
{
    string res;
    int year = 2017 + rand() % 3, month = rand() % 12 + 1, day = rand() % 28 + 1;
    res = to_string(year) + '-';
    if (month < 10)
        res += '0';
    res += to_string(month) + '-';
    if (day < 10)
        res += '0';
    res += to_string(day);
    return res;
}

void generateCDReservations(){
    fstream output;
    output.open("/home/adios/CLionProjects/untitled1/CDReservationsGenerated.txt", ios::out);


    const string templat = "EXEC dbo.addConferenceDayReservation ";

    for (int i = 4; i <= 207; i++)
    {
        for (int j = 0; j < 25; j++)
        {
            string result = templat + to_string(i) + ", " + to_string(getRandomClientID()) + ", \'" + getRandomDate() + "\', " + to_string(rand()%10 + 1);
            output << result << endl;
        }

    }


}



void generateWorkshopReservations(){
    fstream output;
    output.open("/home/adios/CLionProjects/untitled1/WorkshopReservations.txt", ios::out);


    const string templat = "EXEC dbo.addWorkshopReservation ";

    for (int i = 1; i < 5103; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            string result = templat + to_string(i ) + ", " + to_string( (i / 25 * 4  + 819 ) > 1634 ? 0 : (i / 25 * 4 + i%25 + 819 )) + ", \'" + getRandomDate() + "\', " + to_string(rand()%10 + 1);
            output << result << endl;
        }

    }


}

void generateCDUpdater()
{
    fstream output;
    output.open("/home/adios/CLionProjects/untitled1/UpdateCD.txt", ios::out);



    const string templat = "EXEC dbo.updateConferenceDayData ";

    for (int i = 4; i <= 207; i++)
    {
        string result = templat + to_string(i) + ", \'09:00:00\', \'19:00:00\', 200, 100";
        output << result << endl;
    }

}

int main() {
    srand( time( NULL ) );

    generateConferences();
    generateWorkshops();
    generateParticipants();
    generateCDReservations();
    generateCDUpdater();
    generateWorkshopReservations();

    return 0;
}
