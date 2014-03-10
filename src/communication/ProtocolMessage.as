package communication {

	public class ProtocolMessage {
		/*
		--------------------------------------------------------
		|4 bytes|4 bytes|4 bytes|1 byte| 1 byte |(n bytes) data|
		--------------------------------------------------------
			|		|		|		|		|
			V		|		|		|		|
		handler id	|		|		|		|
					V		|		|		|
				ticket ID	|		|		|
							V		|		|
						data length |		|
									V		|
								 status		|
											V
						serialization byte: 0 - protobuff 1 - JSON
		*/

		private var _handlerId:int;

		private var _ticketId:int;

		private var _dataLength:int;

		private var _status:int;

		private var _serialization:int;

		private var _data:*;


		public function get data():* {
			return _data;
		}

		public function set data(value:*):void {
			_data = value;
		}

		public function get serialization():int {
			return _serialization;
		}

		public function set serialization(value:int):void {
			_serialization = value;
		}

		public function get status():int {
			return _status;
		}

		public function set status(value:int):void {
			_status = value;
		}

		public function get dataLength():int {
			return _dataLength;
		}

		public function set dataLength(value:int):void {
			_dataLength = value;
		}

		public function get ticketId():int {
			return _ticketId;
		}

		public function set ticketId(value:int):void {
			_ticketId = value;
		}

		public function get handlerId():int {
			return _handlerId;
		}

		public function set handlerId(value:int):void {
			_handlerId = value;
		}

	}
}
