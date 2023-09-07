import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    connect() {
    }

    open() {
        let callFrame = window.DailyIframe.createFrame();
        callFrame.join({ 
            url: 'https://flowboard.daily.co/flowboarddemo',
            showLeaveButton: true,
        });

        callFrame.on("left-meeting", (event) => {
            callFrame.destroy();
        });
    }
}