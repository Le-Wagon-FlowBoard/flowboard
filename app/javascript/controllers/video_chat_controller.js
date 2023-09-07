import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    connect() {
        console.log('Hello, Stimulus!', this.element);
    }

    open() {
        console.log('open');
        let callFrame = window.DailyIframe.createFrame();
        callFrame.join({ 
            url: 'https://flowboard.daily.co/flowboarddemo',
            showLeaveButton: true,
        });

        callFrame.on("left-meeting", (event) => {
            console.log('left-meeting');
            callFrame.destroy();
        });
    }
}