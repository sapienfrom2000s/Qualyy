import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('Hello World!')
  }

  close(event){
    console.log('close triggered')
    document.getElementsByClassName('modal')[0].classList.remove('is-active')
  }
}
