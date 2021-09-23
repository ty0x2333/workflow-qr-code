import alfy from 'alfy';
import QRCode from 'qrcode';
import temp from 'temp';

const qrCodeImageText = await QRCode.toString(alfy.input, { type: 'utf-8' })

var filePath = temp.path({ suffix: '.png' });
await QRCode.toFile(filePath, alfy.input, { width: 1024 })

alfy.output([{
    title: alfy.input,
    text: {
        copy: qrCodeImageText,
        largetype: qrCodeImageText
    },
    valid: true,
    subtitle: "Press shift to preview",
    icon: {
        path: filePath
    },
    type: 'file',
    arg: filePath,
    quicklookurl: filePath
}]);