import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    static values = { username: String }

    connect() {
        console.log(this.usernameValue)
    }

    open() {
        let callFrame = window.DailyIframe.createFrame();
        callFrame.join({
            url: 'https://flowboard.daily.co/flowboarddemo',
            showLeaveButton: true,
            showFullscreenButton: true,
            userName: this.usernameValue,
            activeSpeakerMode: false,
            theme: {
                colors: {
                    accent: '#374069',
                    accentText: '#c2c6dc',
                    background: '#454a60',
                    backgroundAccent: '#454a60',
                    baseText: '#c2c6dc',
                },
            },
        });

        callFrame.on("left-meeting", (event) => {
            callFrame.destroy();
        });
    }
}