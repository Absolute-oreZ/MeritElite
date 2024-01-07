  class Events {
    final String club;
    final String name;
    final String meritLvl;
    late int meritPoints;
    DateTime date;
    final String description;

    Events(this.club, this.name, this.meritLvl, this.date,this.description) {
      switch (meritLvl) {
        case 'Club':
          meritPoints = 5;
          break;
        case 'University':
          meritPoints = 10;
          break;
        case 'National':
          meritPoints = 30;
          break;
        case 'International':
          meritPoints = 50;
          break;
      }
    }
  }
