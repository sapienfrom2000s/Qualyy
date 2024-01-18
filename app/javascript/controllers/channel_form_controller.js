import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('Hello World!')
  }

  open(event){
    event.preventDefault()
    document.getElementsByClassName('modal')[0].classList.add('is-active')
  }

  close(event){
    console.log('close triggered')
    event.preventDefault()
    document.getElementsByClassName('modal')[0].classList.remove('is-active')
  }
}
