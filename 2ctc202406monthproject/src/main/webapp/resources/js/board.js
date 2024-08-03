document.addEventListener('DOMContentLoaded', function() {
	const gallery = document.getElementById('gallery');
	const thumbnails = gallery.getElementsByTagName('img');

	for (let i = 0; i < thumbnails.length; i++) {

		const thumbnail = thumbnails[i];

		const originalSrc = thumbnail.src;

		thumbnail.addEventListener('click', function() {
			const overlay = document.getElementById('overlay');
			const overlayImg = document.getElementById('overlay-img');

			overlayImg.src = originalSrc;
			overlayImg.style.maxWidth = 'none';
			overlayImg.style.maxHeight = 'none';
			overlayImg.style.width = 'auto';
			overlayImg.style.height = 'auto';

			overlay.style.display = 'flex';

		});
	}
});

function closeOverlay() {
	document.getElementById('overlay').style.display = 'none';
}