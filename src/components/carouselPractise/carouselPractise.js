import { LightningElement } from 'lwc';
import images from '@salesforce/resourceUrl/PlayersImages';

export default class CarouselPractise extends LightningElement {

    players =[
        {
            id:"1",
            header:"Neymar",
            src: images + '/players/neymar.jpg',
            href: "https://en.wikipedia.org/wiki/Neymar",
            description: "Neymar"
        },
        {
            id:"2",
            header:"Messi",
            src: images + '/players/messi.jpg',
            href: "https://en.wikipedia.org/wiki/Lionel_Messi",
            description:  "Messi"
        },
        {
            id:"3",
            header:"Ronaldo",
            src: images + '/players/Ronaldo.jpg',
            href: "https://en.wikipedia.org/wiki/Cristiano_Ronaldo",
            description: "Ronaldo"
        }
    ];
}